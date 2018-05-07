# Creating new base image
## Tested on
- aws-cli/1.15.10 Python/3.6.1 Darwin/17.4.0 botocore/1.10.10
- Docker version 18.03.1-ce, build 9ee9f40

## Get auth from amazon and login via docker. 
```
eval $(aws ecr get-login --no-include-email --region eu-west-1)
```

## Build image
```
docker build -t builders/puppet .
```

## Tag image
```
docker tag builders/puppet:latest <AWS_ACOUNT_ID>.dkr.ecr.eu-west-1.amazonaws.com/builders/puppet:latest
```

## Push to Amazon ECR
```
docker push <AWS_ACOUNT_ID>.dkr.ecr.eu-west-1.amazonaws.com/builders/puppet:latest
```

# Module management
- Only APPROVED or SUPPORTED modules are allowed. 
- All modules should be specified in *puppet/main/Puppetfile*
- Only librarian-puppet can modify *puppet/main/modules* directory
- In order to speed up process of building PRM - modules managed by librarian are stored in the repository. 

## Adding a module
- Add new entry in Puppetfile
- Check if installation works
```librarian-puppet install```
- Package new module to vendor directory
```librarian-puppet package```
- Push changes to repository (expected changes are Puppetfile and new archive in *vendor/puppet/cache/*)

# Build RPM
```docker-compose run build-rpm -f docker-compose.yaml```

RPM will be stored in *builds* directory. 

# Docker - images and container cleanup 

WARNING - this will remove all your containers and images that you have donwloaded or created. 
```
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)
```

# Downloading docker image  

# Directory tree
```
├── Dockerfile
├── README.md
├── builds
├── docker-compose.yaml
├── entrypoints
│   ├── build-rpm.sh
│   ├── common.sh
│   └── develop.sh
└── puppet
    ├── main
    │   ├── Puppetfile
    │   ├── Puppetfile.lock
    │   ├── data
    │   ├── environment.conf
    │   ├── hiera.yaml
    │   ├── manifests
    │   ├── modules
    │   ├── site-modules
    │   └── vendor
    └── production
```

## ./Dockerfile
Base image that will be used for RPM-s and tests.
Have nesssessary gems and packages to build, run and package puppet.

## ./builds
Directory where are rpm-s are stored. We .gitignore this directory.

## ./docker-compose.yaml

Configuration file that provides interface for common operations.
### build-rpm
```
docker-compose run build-rpm -f docker-compose.yaml
```

Build puppet rpm and put it in *./build* directory.

Expected output:

```
> docker-compose run build-rpm -f docker-compose.yaml
Changed directory to: /tmp/build/puppet/main
Installing modules in: /tmp/build/puppet/main/modules
Changed directory to: /tmp/build
Detecting branch: master
Detecting latest commit hash: 926bc8299ed7b302a1d0f1cdbf7b901e9f78e2c8
Changed directory to: /tmp/build/puppet
Setting RPM parameters
RPM name: puppet-code
RPM version: 1
RPM iteration: 1525698957
Running fpm gem...
Created package {:path=>"puppet-code-1-1525698957.noarch.rpm"}
Moved puppet-code-1-1525698957.noarch.rpm to /tmp/build/builds directory
Status: Build complete.
```

## ./entrypoints
Shell scripts that docker-compose uses as a entrypoint for a container

## ./puppet
Directory that is store puppet environment directory.

### ./puppet/main
Environment directory

### ./puppet/main/Puppetfile
### ./puppet/main/Puppetfile.lock

### ./puppet/main/modules
Directory managed by librarian-puppet and Puppetfile. Dont put anything manually there. Only via Puppetfile.
### ./puppet/main/site-modules
Directory for user modules. In order to create modules use:
```
 puppet module generate <MODULE_NAME>
```
### ./puppet/main/vendor
Cache directory for modules that we are downloading from internet. In order to speed up build procedure we have a local copy of those modules. We can adjust build-rpm.sh to always download modules from the internet but this process is expensive in terms of time.
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
- you should have 

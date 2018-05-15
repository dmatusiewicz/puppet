FROM amazonlinux:latest

LABEL dvsa.mot.aws.os="Amazon Linux" \
      dvsa.mot.aws.ami-type="builder"

RUN yum upgrade -y && \
    yum update -y && \
    # Install ruby dependencies 
    yum install -y ruby-devel gem gcc findutils git-core rpm-build aws-cli && \
    # Install software for rpm creation and puppet module management
    gem install fpm librarian-puppet && \
    # Install puppet (The only reason to update this file is to lock puppet version here)
    rpm -Uvh https://yum.puppetlabs.com/puppet5/puppet5-release-el-6.noarch.rpm && \
    yum install -y puppet-agent && \
    # Clean yum cache
    yum clean all    
ADD entrypoints /etc/rc.d/init.d
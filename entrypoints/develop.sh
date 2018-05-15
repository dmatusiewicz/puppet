#!/bin/bash -e

# Load common settings 
. /etc/init.d/common.sh

echo ${ROLE}
FACTER_role=${ROLE} puppet apply --environment main /etc/puppetlabs/code/environments/main/manifests/site.pp

if [ ${DEBUG:-''} == "true" ];then
    /bin/bash
fi 

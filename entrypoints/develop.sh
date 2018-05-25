#!/bin/bash

# Load common settings 
. /etc/init.d/common.sh

echo ${ROLE}
FACTER_role=${ROLE} FACTER_account_id=${ACCOUNT_ID} FACTER_environment=${ENVIRONMENT} puppet apply --environment main /etc/puppetlabs/code/environments/main/manifests/site.pp

if [ ${DEBUG:-''} == "true" ];then
    /bin/bash
fi 

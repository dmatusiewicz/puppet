#!/bin/bash -e

# Load common settings 
. /etc/init.d/common.sh


puppet apply --environment main /etc/puppetlabs/code/environments/main/manifests/site.pp

/bin/bash
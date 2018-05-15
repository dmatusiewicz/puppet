#!/bin/bash -e

# Load common settings 
. /etc/init.d/common.sh

cd ${BUILD_DIR}/puppet/main
librarian-puppet package
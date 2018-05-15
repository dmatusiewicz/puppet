#!/bin/bash -e

# Load common settings 
. /etc/init.d/common.sh

cd ${BUILD_DIR}/puppet/main
echo -e "${SET_GREEN}[Shell] Installing modules${RESET}"
librarian-puppet install --clean --destructive --verbose

echo -e "${SET_GREEN}[Shell] Packaging modules${RESET}"
librarian-puppet package --clean --destructive --verbose
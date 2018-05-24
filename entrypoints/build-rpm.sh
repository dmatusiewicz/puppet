#!/bin/bash -e

# Load common settings 
. /etc/init.d/common.sh

cd ${BUILD_DIR}/puppet/main
echo -e "Changed directory to: ${SET_GREEN}`pwd`${RESET}"

echo -e "Installing modules in: ${SET_GREEN}`pwd`/modules${RESET}"
librarian-puppet install --local

echo -e "Branch: ${SET_GREEN}${BRANCH}${RESET}"
echo -e "Commit hash: ${SET_GREEN}${COMMIT_ID}${RESET}"

cd ${BUILD_DIR}/puppet
echo -e "Changed directory to: ${SET_GREEN}`pwd`${RESET}"

echo "Setting RPM parameters"
RPM_NAME=puppet-code
RPM_VERSION=1
RPM_ITERATION=`date +%s`
RPM_ARCH=noarch
echo -e "RPM name: ${SET_GREEN}${RPM_NAME}${RESET}"
echo -e "RPM version: ${SET_GREEN}${RPM_VERSION}${RESET}"
echo -e "RPM iteration: ${SET_GREEN}${RPM_ITERATION}${RESET}"
echo "Running fpm gem..."

fpm --epoch 0 -a ${RPM_ARCH} --workdir "${WORKSPACE:-/tmp/build/puppet}" -d 'puppet-agent' -t rpm -s dir -C main --exclude vendor --exclude .tmp --exclude .librarian --exclude .gitignore --prefix /etc/puppetlabs/code/environments/main -f -n ${RPM_NAME} -v ${RPM_VERSION} --iteration  ${RPM_ITERATION} --rpm-summary "Commit: ${COMMIT_ID} Build number: ${BUILD_NUMBER:-'local'} Branch: ${BRANCH}" 

RPM="${RPM_NAME}-${RPM_VERSION}-${RPM_ITERATION}.${RPM_ARCH}.rpm"
mv ${RPM} ../builds
echo -e "Moved ${SET_GREEN}${RPM}${RESET} to ${BUILD_DIR}/builds directory"
echo -e "Status: ${SET_GREEN}Build complete.${RESET}"


#!/bin/bash -e

# Load common settings 
. /etc/init.d/common.sh

cd builds
FILE_TO_UPLOAD=`find . -type f -name 'puppet-code*'  -printf "%f\n" | sort -n | tail -n 1`
if [ -e ${FILE_TO_UPLOAD} ]; then 
 echo "Uploading ${FILE_TO_UPLOAD} to ${ACCOUNT_ID}-${BUCKET_NAME_SUFFIX}/${BUCKET_DIRECTORY}"
 aws s3api put-object --bucket ${ACCOUNT_ID}-${BUCKET_NAME_SUFFIX} --key ${BUCKET_DIRECTORY}/${BRANCH}/puppet-code.rpm --body ${FILE_TO_UPLOAD}
else 
  echo "Directory is empl"
fi 

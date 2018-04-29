#!/bin/bash

# It is worth having common.sh - if repo creates more than one RPM. 

# Loading Puppet variables
source /etc/profile.d/puppet-agent.sh

# Adding support for AWS session
if [ -z "${AWS_SESSION_TOKEN}" ]; then
  unset AWS_SESSION_TOKEN
fi

if [ -z "${AWS_PROFILE}" ]; then
  unset AWS_PROFILE
fi

if [ -z "${AWS_SECRET_ACCESS_KEY}" ]; then
  unset AWS_SECRET_ACCESS_KEY
fi

if [ -z "${AWS_ACCESS_KEY_ID}" ]; then
  unset AWS_ACCESS_KEY_ID
fi

if [ -z "${AWS_MFA_EXPIRY}" ]; then
  unset AWS_MFA_EXPIRY
fi

# Adding puppet environment
if [ -z "${environment}" ]; then
  unset environment
fi

# Color variables 
SET_GREEN='\e[32m'
SET_RED='\e[31m'
RESET='\e[0m'

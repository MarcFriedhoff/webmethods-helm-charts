#!/bin/bash


# Determine docker_cmd
if [[ -n "$docker_cmd" ]]; then
  # Use existing environment variable
  docker_cmd="$docker_cmd"
elif command -v docker &> /dev/null; then
  docker_cmd="docker"
elif command -v podman &> /dev/null; then
  docker_cmd="podman"
else
  echo "Error: Neither docker_cmd is set, nor docker/podman found in PATH." >&2
  exit 1
fi

# check if installer.bin exists
if [ ! -f installer.bin ]; then
  echo "installer.bin not found. Please place the installer.bin in the current directory. To download the installer visit https://www.ibm.com/support/fixcentral/ and search for 'webMethods Installer'. Download the latest version for Linux and place it in the current directory as installer.bin."
  exit 1
fi

# check if ENTITLEMENT_USER and ENTITELEMENT_KEY are set
if [ -z "${ENTITLEMENT_USER}" ] || [ -z "${ENTITLEMENT_KEY}" ]; then
  echo "Please set the ENTITLEMENT_USER and ENTITLEMENT_KEY environment variables. To obtain entitlment key and user, visit https://www.ibm.com/mysupport/ and log in with your IBM ID. Then navigate to 'My Products and Services' and find the webMethods product you are entitled to."
  exit 1
fi

sed "s/%ENTITLEMENT_USER%/${ENTITLEMENT_USER}/g;s/%ENTITLEMENT_KEY%/${ENTITLEMENT_KEY}/g;" dcc_script_template > dcc_script

${docker_cmd} build --platform=linux/amd64 -t dcc:latest .
#!/bin/bash
set -e

# Defaults for command line arguments
DISTRO="ubuntu"		# ubuntu, debian
RELEASE="latest" 	# latest, buster-slim, ...
MYFLAVOR="slim"		# slim vs devel

# Other defaults
USER="alberto"

if [[ $# > 0 ]]; then
	DISTRO="$1"
	if [[ $# > 1 ]]; then
		RELEASE="$2"
		if [[ $# > 2 ]]; then
			MYFLAVOR="$3"
		fi
	fi
fi


NAME=${DISTRO}:${RELEASE}
echo "Creating image for NAME=${DISTRO}:${RELEASE} with tag ${DISTRO}-my${MYFLAVOR}-${RELEASE}"

docker build -t "${DISTRO}-my${MYFLAVOR}-${RELEASE}" --build-arg name=${NAME} --build-arg distro=${DISTRO} --build-arg distro-release=${RELEASE} --build-arg user=${USER}  --build-arg myflavor=${MYFLAVOR} ./

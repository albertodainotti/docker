#!/bin/bash
set -e

# Defaults for command line arguments
DISTRO="ubuntu"		# ubuntu, debian
RELEASE="latest" 	# latest, bionic, buster-slim, ...
MYFLAVOR="devel"	# slim vs devel

# Other defaults
#USER="inetintel-ioda"
#GROUP="coc-inetintel-ioda"
USER="alberto"
GROUP="alberto"

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
echo "Creating image for ${DISTRO}:${RELEASE} with tag ${DISTRO}-my${MYFLAVOR}-${RELEASE}"

docker build -t "${DISTRO}-my${MYFLAVOR}-${RELEASE}" --build-arg name=${NAME} --build-arg distro=${DISTRO} --build-arg distro-release=${RELEASE} --build-arg user=${USER} --build-arg group=${GROUP} --build-arg myflavor=${MYFLAVOR} ./

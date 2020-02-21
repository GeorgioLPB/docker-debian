#!/bin/bash
cd "$(dirname ${0})" && homedir="$(pwd -P)" && cd "${homedir}"
appli="$(echo ${homedir} | awk -F/ '{print $NF}')"
machine=$(uname -m)

case ${machine} in
	'x86_64')
		release="amd64"
		;;
	'armv7l')
		release="arm32v7"
		;;
	*)
		echo "Machine ${machine} Unsupported"
		exit 1
		;;
esac

[ "${release}" == "amd64" ] && release='latest'

docker run --interactive --tty --rm "ggregorio/${appli}:${release}" /bin/sh


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

[ ! -f "./Dockerfile.${release}" ] && echo "Missing file: Dockerfile.${release}" && exit 1

docker build -t ggregorio/${appli}:${release} -f Dockerfile.${release} . && \
	docker save -o "./${appli}-${release}.tar" "ggregorio/${appli}:${release}" && \
	docker rmi "ggregorio/${appli}:${release}" && \
	docker load -i "./${appli}-${release}.tar" && \
	docker push "ggregorio/${appli}:${release}" && \
	if [ "${release}" == "amd64" ] ; then
		docker tag "ggregorio/${appli}:${release}" "ggregorio/${appli}:latest" && \
		docker push  "ggregorio/${appli}:latest" && \
		docker rmi "ggregorio/${appli}:latest"
	fi && \
	docker rmi "ggregorio/${appli}:${release}" && \
	rm -vf "./${appli}-${release}.tar"


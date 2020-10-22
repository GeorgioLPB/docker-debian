FROM debian:10.6
#
# https://hub.docker.com/_/debian
# https://github.com/just-containers/s6-overlay/releases
#
LABEL maintainer georges.gregorio@gmail.com

ENV \
	s6_release='2.1.0.2' \
	s6_arch='amd64' \
	s6_sha256='52460473413601ff7a84ae690b161a074217ddc734990c2cdee9847166cf669e' \
	s6_url="https://github.com/just-containers/s6-overlay/releases/download"

RUN set -eux; \
	apt-get update && \
	apt-get install -y --no-install-recommends \
		procps wget ca-certificates && \
	rm -r /var/lib/apt/lists/* && \
	# S6
	cd /tmp && \
	wget -O "./s6-overlay-${s6_arch}.tar.gz" \
		"${s6_url}/v${s6_release}/s6-overlay-${s6_arch}.tar.gz" && \
	echo "${s6_sha256} *s6-overlay-${s6_arch}.tar.gz" | sha256sum -c - && \
	tar -xzvf "/tmp/s6-overlay-${s6_arch}.tar.gz" -C / && \
	rm -fv "/tmp/s6-overlay-${s6_arch}.tar.gz"

CMD [ "/init" ]


FROM gitpod/workspace-full

USER root

RUN apt-get update \
   && apt-get install -y uidmap iptables \
   && apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*

RUN echo '#!/bin/sh\n\
set -eu\n\
for module; do\n\
	if [ "${module#-}" = "$module" ]; then\n\
		ip link show "$module" || true\n\
		lsmod | grep "$module" || true\n\
	fi\n\
done\n\
export PATH="/usr/sbin:/usr/bin:/sbin:/bin"\n\
exec modprobe "$@"\n'\
> /usr/local/bin/modprobe && chmod +x /usr/local/bin/modprobe && cat /usr/local/bin/modprobe
RUN modprobe ip_tables
ENV SKIP_IPTABLES=1

USER gitpod
RUN curl -sSL https://get.docker.com/rootless | sh

ENV XDG_RUNTIME_DIR=/tmp/docker-33333
ENV PATH=/home/gitpod/bin:$PATH
ENV DOCKER_HOST=unix:///tmp/docker-33333/docker.sock

USER root

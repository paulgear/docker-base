ARG     REGISTRY=""
ARG     DISTRO=ubuntu
ARG     RELEASE=noble
FROM    ${REGISTRY}${DISTRO}:${RELEASE}

ARG     REGION=ap-southeast-2
ARG     MIRROR=http://${REGION}.ec2.archive.ubuntu.com
# ARG     MIRROR=http://azure.archive.ubuntu.com

ENV     DEBIAN_FRONTEND=noninteractive
# RELEASE must be redeclared, because it's used before FROM
# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG     RELEASE
ARG     PKGS="\
bind9-host \
byobu \
curl \
iproute2 \
less \
mtr-tiny \
netcat-openbsd \
rsync \
strace \
wget \
"

RUN     sed -ri \
            -e "s!http://archive\.ubuntu\.com!${MIRROR}!" \
            -e "1i deb ${MIRROR}/ubuntu/ ${RELEASE}-security main restricted universe multiverse\n" \
            /etc/apt/sources.list && \
        apt update && \
        apt install -y --no-install-recommends ${PKGS} && \
        apt upgrade -y --autoremove --purge && \
        rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/bash"]

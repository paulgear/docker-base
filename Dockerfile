ARG     REGISTRY=
ARG     DISTRO=ubuntu
ARG     RELEASE=focal
FROM    ${REGISTRY}${DISTRO}:${RELEASE}

#ARG     MIRROR=
ARG     MIRROR=mirror.internode.on.net/pub/ubuntu
#ARG    REGION=ap-southeast-2
#ARG    MIRROR=${REGION}.ec2.archive.ubuntu.com

ENV     DEBIAN_FRONTEND=noninteractive

ENV     PKGS="\
bind9-host \
byobu \
curl \
iproute2 \
mtr-tiny \
netcat-openbsd \
rsync \
wget \
"

RUN     sed -ri -e "s!(archive|security)\.ubuntu\.com!${MIRROR}!" /etc/apt/sources.list && \
        apt update && \
        apt upgrade -y && \
        apt install --no-install-recommends -y ${PKGS} && \
        apt autoremove --purge -y && \
        rm -rf /var/lib/apt/lists/* && \
        rm -fv /etc/ssh/ssh_host_*key*

ENTRYPOINT ["/bin/bash"]

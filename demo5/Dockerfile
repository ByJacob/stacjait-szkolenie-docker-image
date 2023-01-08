FROM ubuntu
ARG S6_OVERLAY_VERSION=3.1.2.1

RUN apt-get update && apt-get install -y nginx xz-utils

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

COPY s6-rc.d/ /etc/s6-overlay/s6-rc.d/
RUN chmod a+x /etc/s6-overlay/s6-rc.d/*/run
ENV MY_USER=UNKNOWN

ENTRYPOINT ["/init"]
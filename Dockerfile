FROM misotolar/alpine:3.21.3 AS build

LABEL maintainer="michal@sotolar.com"

ENV FIREHOL_LEVEL1=1
ENV FIREHOL_LEVEL1_URL=https://iplists.firehol.org/files/firehol_level1.netset
ENV FIREHOL_LEVEL2=1
ENV FIREHOL_LEVEL2_URL=https://iplists.firehol.org/files/firehol_level2.netset
ENV FIREHOL_LEVEL3=1
ENV FIREHOL_LEVEL3_URL=https://iplists.firehol.org/files/firehol_level3.netset
ENV FIREHOL_LEVEL4=0
ENV FIREHOL_LEVEL4_URL=https://iplists.firehol.org/files/firehol_level4.netset

ENV IPSETS_UPDATE_SCHEDULE="0 13 * * *"

WORKDIR /usr/local/ipsets

RUN set -ex; \
    apk add --no-cache \
        bash \
        ipset \
        wget \
    ; \
    rm -rf \
        /var/cache/apk/* \
        /var/tmp/* \
        /tmp/*

COPY resources/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY resources/ipsets-update.sh /usr/local/bin/ipsets-update.sh

STOPSIGNAL SIGKILL
ENTRYPOINT ["entrypoint.sh"]
CMD ["crond", "-f"]

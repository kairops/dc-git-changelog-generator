FROM alpine:3.7

RUN apk add --no-cache git bash coreutils

ADD build-changelog.sh /usr/local/bin/build-changelog.sh
RUN chmod +x /usr/local/bin/build-changelog.sh

VOLUME ["/opt/source"]
WORKDIR /opt/source
ENTRYPOINT ["/usr/local/bin/build-changelog.sh"]

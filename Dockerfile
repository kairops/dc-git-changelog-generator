FROM alpine

RUN apk add --no-cache git bash coreutils

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME ["/workspace"]
WORKDIR /workspace
ENTRYPOINT ["/entrypoint.sh"]

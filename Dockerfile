FROM alpine:3.11.5

RUN apk add --no-cache git bash

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME ["/workspace"]
WORKDIR /workspace
ENTRYPOINT ["/entrypoint.sh"]

FROM        gliderlabs/alpine:edge
MAINTAINER  Adnan Hajdarevic <adnanh@gmail.com>

ENV         GOPATH /go
ENV         WEBHOOK github.com/adnanh/webhook
ENV         SRCPATH ${GOPATH}/src/
RUN         mkdir /go
RUN         adduser -S webhook
RUN         apk add --update -t build-deps go git libc-dev gcc libgcc && \
            go get $WEBHOOK && cd $SRCPATH/$WEBHOOK &&  go build -o /usr/local/bin/webhook && \
            apk del --purge build-deps && \
            rm -rf /var/cache/apk/* && \
            rm -rf ${GOPATH}

EXPOSE      9000
ENTRYPOINT  ["/usr/local/bin/webhook"]

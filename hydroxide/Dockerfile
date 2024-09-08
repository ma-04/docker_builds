# builder OS
FROM golang:1-alpine as builder

# update / dependencies
RUN apk --update upgrade \
&& apk --no-cache --no-progress add git make gcc musl-dev bash \
&& rm -rf /var/cache/apk/*

# docker container settings
ENV GOPATH /go

# build hydroxide
RUN git -C ./src/ clone https://github.com/emersion/hydroxide/
RUN cd /go/src/hydroxide/cmd/hydroxide && go build . && go install . && cd

# container OS
FROM alpine:3

ENV XDG_CONFIG_HOME /
EXPOSE 1025 1143 8080

# update / dependencies
RUN apk --update upgrade \
    && apk --no-cache add ca-certificates bash openrc \
    && rm -rf /var/cache/apk/*

RUN addgroup -S hydroxide && adduser -h /hydroxide -S hydroxide -G hydroxide
RUN chown -R hydroxide:hydroxide /hydroxide

# copy hydroxide
COPY --chown=hydroxide:hydroxide --from=builder /go/bin/hydroxide /usr/bin/hydroxide

USER hydroxide
WORKDIR /hydroxide

ENTRYPOINT ["hydroxide", "-debug", "-smtp-host", "0.0.0.0", "-imap-host", "0.0.0.0", "-carddav-host", "0.0.0.0"]

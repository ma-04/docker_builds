# syntax=docker/dockerfile:1

# Pinned upstream release (bumped automatically by .github/workflows/bump-hydroxide.yml).
# Any git ref works, e.g. --build-arg HYDROXIDE_VERSION=master for a dev build.
ARG HYDROXIDE_VERSION=v0.2.32

# --- build stage: runs on the build host and cross-compiles for the target arch ---
FROM --platform=$BUILDPLATFORM golang:1-alpine AS builder

ARG HYDROXIDE_VERSION
ARG TARGETOS
ARG TARGETARCH

RUN apk add --no-cache git

WORKDIR /src
RUN git clone --depth 1 --branch "${HYDROXIDE_VERSION}" https://codeberg.org/emersion/hydroxide.git .

RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    CGO_ENABLED=0 GOOS="${TARGETOS}" GOARCH="${TARGETARCH}" \
    go build -trimpath -ldflags="-s -w" -o /out/hydroxide ./cmd/hydroxide

# --- runtime stage ---
FROM alpine:3

RUN apk add --no-cache ca-certificates tzdata \
    && addgroup -g 1000 -S hydroxide \
    && adduser -u 1000 -h /hydroxide -S -G hydroxide hydroxide

COPY --from=builder /out/hydroxide /usr/local/bin/hydroxide

# hydroxide stores its config in $XDG_CONFIG_HOME/hydroxide -> /hydroxide (mount a volume there)
ENV XDG_CONFIG_HOME=/

USER 1000:1000
WORKDIR /hydroxide

# 1025 SMTP, 1143 IMAP, 8080 CardDAV
EXPOSE 1025 1143 8080

ENTRYPOINT ["hydroxide", "-smtp-host", "0.0.0.0", "-imap-host", "0.0.0.0", "-carddav-host", "0.0.0.0"]
CMD ["serve"]

[![build](https://github.com/ma-04/docker_builds/actions/workflows/build.yml/badge.svg)](https://github.com/ma-04/docker_builds/actions/workflows/build.yml)
# Hydroxide Dockerfile

A multi-arch (amd64 / arm64) image for [hydroxide](https://codeberg.org/emersion/hydroxide), a third-party, open-source implementation of the ProtonMail Bridge protocol.

Before submitting issues, please see the [hydroxide](https://codeberg.org/emersion/hydroxide) docs and [Proton](https://proton.me/support) support pages for hydroxide and Proton Mail specific matters.

I offer no guarantees that this is a secure way to store and pass your hydroxide authentication information to other apps. It is one working example to get you started. If you can improve the security of this example configuration, please send a pull request.

## Images and tags

| Registry | Image |
| --- | --- |
| Docker Hub | `ma04/hydroxide` |
| GitHub | `ghcr.io/ma-04/hydroxide` |

| Tag | Meaning |
| --- | --- |
| `latest`, `0.2.32`, `0.2` | Built from the pinned upstream release in the [Dockerfile](Dockerfile). Bumped by PR when upstream releases. |
| `dev` | Built from upstream `master` on the first of every month (and on manual runs). |
| `sha-<short>` | Stable build from a specific commit of this repo. |

The image runs as UID/GID `1000` and stores its config in `/hydroxide`. Mount a volume there and make sure the host folder is writable by that user.

## Running hydroxide as a Docker container

You can do this with `docker run` or `docker compose`.

docker run:

```
mkdir -p hydroxide-data
docker run -d --name hydroxide -p 1025:1025 -p 1143:1143 -p 8080:8080 -v ./hydroxide-data:/hydroxide ma04/hydroxide:latest serve
```

Ports: `1025` SMTP (sending), `1143` IMAP (receiving), `8080` CardDAV.

If your host user is not UID 1000 (check with `id -u`), add `--user "$(id -u):$(id -g)"` so hydroxide can write to the data folder.

After the container is up, log in with your Proton username:

```
docker exec -it hydroxide hydroxide auth <proton username>
```

## Docker Compose

See [docker-compose.yml](docker-compose.yml). Adjust it as needed, then:

```
mkdir -p hydroxide-data
docker compose up -d
docker exec -it hydroxide hydroxide auth <proton username>
```

You can also reuse an existing hydroxide config by moving it into the `hydroxide-data` folder and restarting the container.

## Debug logging

Pass `-debug` before the subcommand to get verbose logs. Because the host flags are part of the image entrypoint, override it:

```
docker run --rm -it --entrypoint hydroxide -v ./hydroxide-data:/hydroxide ma04/hydroxide:latest -debug -smtp-host 0.0.0.0 -imap-host 0.0.0.0 -carddav-host 0.0.0.0 serve
```

## Building locally

```
docker build -t hydroxide ./hydroxide
# or from upstream master:
docker build --build-arg HYDROXIDE_VERSION=master -t hydroxide:dev ./hydroxide
```

# ubuntu

Ubuntu `24.04` with a few network troubleshooting tools installed. Multi-arch (amd64 / arm64), rebuilt monthly on the fresh upstream base image.

| Registry | Image |
| --- | --- |
| Docker Hub | `ma04/ubuntu` |
| GitHub | `ghcr.io/ma-04/ubuntu` |

Installed packages:
- ca-certificates
- curl
- wget
- iputils-ping (with `setcap` support so ping works for non-root users)
- net-tools
- dnsutils

```
docker run --rm -it ma04/ubuntu:latest
```

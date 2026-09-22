[![build](https://github.com/ma-04/docker_builds/actions/workflows/build.yml/badge.svg)](https://github.com/ma-04/docker_builds/actions/workflows/build.yml)
# docker_builds
Home for Dockerfiles and dependent data. All images are built for `linux/amd64` and `linux/arm64` and published to both Docker Hub (`ma04/<image>`) and GitHub Container Registry (`ghcr.io/ma-04/<image>`).

# Images
- [x] [Hydroxide](https://codeberg.org/emersion/hydroxide) - A third-party, open-source implementation of the ProtonMail Bridge protocol. [How to use](hydroxide/README.md)
- [x] [ubuntu](https://hub.docker.com/_/ubuntu) - A customised version of the official ubuntu image with some network tools for troubleshooting. [Details](base-ubuntu/README.md)

# Tags
| Tag | Meaning |
| --- | --- |
| `latest` | Latest build from `main` (pinned versions in each Dockerfile). |
| `<version>` | The pinned upstream version, e.g. `0.2.32` / `0.2` for hydroxide, `24.04` for ubuntu. |
| `dev` | hydroxide only: built from upstream `master` monthly. |
| `sha-<short>` | Build from a specific commit of this repo. |

# How it is built
- `build.yml` runs on pushes to `main`, pull requests (build only, no push), manual dispatch and on the first of every month.
- The monthly run rebuilds every image on fresh base images and refreshes `hydroxide:dev` from upstream master.
- `bump-hydroxide.yml` checks upstream weekly and opens a PR when a new hydroxide release is out.
- Dependabot is configured for GitHub Actions and the Dockerfile base images.
- Dockerfiles are linted with hadolint (config in `.hadolint.yaml`).

Publishing to Docker Hub requires the `DOCKERHUB_NAMESPACE` repository variable plus the `DOCKERHUB_USERNAME` / `DOCKERHUB_TOKEN` secrets. Without the variable, images go to GHCR only.

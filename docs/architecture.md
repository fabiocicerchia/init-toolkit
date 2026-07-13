# Architecture

## Overview

init-toolkit is a single, tiny Alpine image whose only job is to bundle the
readiness-ordering helpers that teams otherwise re-download ad hoc. It runs as
a Kubernetes initContainer, a Compose `depends_on` companion, or an entrypoint
wrapper — then gets out of the way by `exec`ing your real process.

## Components

- **`bin/wait-for`** — the front door. Parses `tcp://` / `http(s)://` targets,
  polls each until reachable (netcat for TCP, a 2xx/3xx response for HTTP),
  honours `-t <timeout>`, then `exec`s the command after `--`.
- **`bin/healthcheck-http` / `bin/healthcheck-tcp`** — one-line probes meant for
  a Dockerfile `HEALTHCHECK` in *your* image.
- **Vendored upstreams** — `wait-for-it` (pinned commit) and `dockerize` (pinned
  release), copied in from a build stage so the final image carries only the
  binaries, not the toolchain that fetched them.

## Build

Multi-stage `Dockerfile`: a `fetch` stage downloads and verifies the vendored
tools, the runtime stage installs the minimal apk packages, adds a non-root
user (`uid 10001`), and copies in the helpers. Images are built multi-arch
(`linux/amd64,linux/arm64`) and published to GHCR by the release workflow.

## Decisions

- **Non-root by default** — the image runs as `uid 10001`; init work rarely
  needs root.
- **Pinned everything** — apk versions, the wait-for-it commit, the dockerize
  release, and all GitHub Actions are pinned for reproducible, auditable builds.
- **No app runtime** — deliberately no language runtime; the image is a toolbox,
  not a base image.

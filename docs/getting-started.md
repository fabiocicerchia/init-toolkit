# Getting Started

## Prerequisites

- Docker (or a Kubernetes / Compose runtime that can pull images).
- Nothing to install locally — everything ships inside the image.

## The image

```sh
docker pull ghcr.io/fabiocicerchia/init-toolkit:latest
```

It bundles four helpers on `PATH`:

| Binary             | Waits on / does                                            |
|--------------------|------------------------------------------------------------|
| `wait-for`         | `tcp://` and `http(s)://` targets, then `exec`s a command  |
| `wait-for-it`      | the classic TCP wait script (pinned upstream commit)       |
| `dockerize`        | wait for deps + render config templates from env           |
| `healthcheck-http` / `healthcheck-tcp` | one-line `HEALTHCHECK` probes          |

## First run

Block until a database accepts TCP connections, then start your app:

```sh
docker run --rm ghcr.io/fabiocicerchia/init-toolkit \
  tcp://db:5432 http://api:8080/healthz -t 120 -- echo "deps ready"
```

`-t` is the timeout in seconds; everything after `--` is the command to exec
once all targets are reachable. See [`../examples/`](../examples/) for
Kubernetes initContainer and Compose usage.

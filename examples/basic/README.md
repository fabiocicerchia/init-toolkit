# Basic Example

What it shows: hold a container back until its dependencies answer, then start.

## Kubernetes initContainer

```yaml
initContainers:
  - name: wait-for-db
    image: ghcr.io/fabiocicerchia/init-toolkit
    args: ["tcp://postgres:5432", "http://api:8080/healthz", "-t", "120"]
```

The pod's main container starts only after both targets are reachable (or the
init fails after 120s).

## Docker Compose

```yaml
services:
  app:
    image: your-app
    entrypoint: ["wait-for", "tcp://db:5432", "--", "./server"]
  # 'wait-for' is on PATH if you COPY it in, or use init-toolkit as a
  # depends_on companion — see the Kubernetes snippet above.
```

## Plain Docker

```sh
docker run --rm ghcr.io/fabiocicerchia/init-toolkit \
  tcp://db:5432 -t 30 -- echo reachable
```

# init-toolkit

> A micro image bundling the readiness-ordering helpers everyone re-downloads
> ad hoc: **wait-for-it**, **dockerize**, and small **healthcheck** utilities.

[![code-quality](https://github.com/fabiocicerchia/init-toolkit/actions/workflows/code-quality.yml/badge.svg)](https://github.com/fabiocicerchia/init-toolkit/actions/workflows/code-quality.yml)
[![security](https://github.com/fabiocicerchia/init-toolkit/actions/workflows/security.yml/badge.svg)](https://github.com/fabiocicerchia/init-toolkit/actions/workflows/security.yml)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)
[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/fabiocicerchia/init-toolkit/badge)](https://securityscorecards.dev/viewer/?uri=github.com/fabiocicerchia/init-toolkit)
[![Release](https://img.shields.io/github/v/release/fabiocicerchia/init-toolkit)](https://github.com/fabiocicerchia/init-toolkit/releases)

Use it as a Kubernetes initContainer, a Compose `depends_on` companion, or an
entrypoint wrapper. `wait-for` is a single front door with TCP *and* HTTP
checks. Small surface, easy to keep patched.

## Features

- **`wait-for`** — wait for `tcp://` / `http(s)://` targets, then exec a command.
- **`wait-for-it`** — the classic script, unmodified (pinned commit).
- **`dockerize`** — wait for deps + template config files from env.
- **`healthcheck-http` / `healthcheck-tcp`** — one-line `HEALTHCHECK` probes.

## Install

```sh
curl -fsSL https://raw.githubusercontent.com/fabiocicerchia/init-toolkit/main/install.sh | bash
```

Or pull the image directly:

```sh
docker pull ghcr.io/fabiocicerchia/init-toolkit:latest
```

## Usage

Kubernetes initContainer:

```yaml
initContainers:
  - name: wait-for-db
    image: ghcr.io/fabiocicerchia/init-toolkit
    args: ["tcp://postgres:5432", "http://api:8080/healthz", "-t", "120"]
```

Compose:

```yaml
services:
  app:
    entrypoint: ["wait-for", "tcp://db:5432", "--", "./server"]
```

Healthcheck in your own Dockerfile:

```dockerfile
COPY --from=ghcr.io/fabiocicerchia/init-toolkit /usr/local/bin/healthcheck-http /usr/local/bin/
HEALTHCHECK CMD ["healthcheck-http", "http://127.0.0.1:8080/healthz"]
```

## Documentation

Full docs live in [`docs/`](docs/). Runnable examples live in
[`examples/`](examples/).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). By participating you agree to the
[Code of Conduct](CODE_OF_CONDUCT.md).

## Security

Found a vulnerability? See [SECURITY.md](SECURITY.md) — please don't open a
public issue.

## Support

Need help implementing this? [Get in touch](https://fabiocicerchia.it/contact).

## License

[Apache 2.0](LICENSE) © 2026 Fabio Cicerchia. Bundled wait-for-it.sh and
dockerize keep their own upstream MIT licenses.

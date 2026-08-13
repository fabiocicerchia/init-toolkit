# CLAUDE.md

Guidance for Claude Code (and other AI agents) working in this repo.

## Project

init-toolkit is a tiny multi-stage Alpine Docker image bundling readiness
helpers for init containers: `wait-for` (TCP + HTTP checks, the front door),
vendored `wait-for-it` and `dockerize`, and `healthcheck-http`/`healthcheck-tcp`
probes. The helpers are POSIX/bash scripts in `bin/`; the image is defined by
`Dockerfile`. No application runtime — it's a toolbox image.

## Commands

```sh
# build:  make build
# test:   make test   (builds the image, runs ./test.sh smoke tests)
# lint:   make lint   (hadolint on Dockerfile + shellcheck on bin/ and test.sh)
# run:    docker run --rm ghcr.io/fabiocicerchia/init-toolkit tcp://host:port -t 30 -- cmd
make help    # Show this help
make setup   # Install the pre-commit hook
make build   # Build the image locally
make lint    # Lint Dockerfile (hadolint) + shell scripts (shellcheck)
make test    # Build + run smoke tests
make push    # Push the single-arch image
make release # Build + push multi-arch (usually done by CI)
```

## Tooling

- `make setup` installs the pre-commit hook, and that is the whole of it.
  Don't add a `.githooks/` directory: `core.hooksPath` replaces `.git/hooks/`
  wholesale, so setting it silently stops every pre-commit hook from running.
- Hooks are pinned by commit SHA with the tag in a trailing comment. A tag can
  be moved, a SHA cannot.
- CI runs this same `.pre-commit-config.yaml` through `pre-commit/action`, so
  what passes locally is what gates the pull request.

## Conventions

- Match existing style; don't reformat unrelated code. Shell stays POSIX-sh
  where it already is (`test.sh`, `healthcheck-*`); `bin/wait-for` is bash.
- Conventional Commits for messages — they drive the release (see CONTRIBUTING.md).
- Update `docs/` and `examples/` with behavior changes.
- CHANGELOG.md and version.txt are managed by release-please — don't edit by hand.
- Never commit secrets; CI runs gitleaks. Keep `.env` out of git.

## Guardrails

- Keep the image small: no new apk packages or dependencies without a clear
  reason. Pin any new package/action version (apk versions, action SHAs).
- Don't touch the vendored pins (wait-for-it commit, dockerize release) casually.
- Ask before large refactors or destructive operations.

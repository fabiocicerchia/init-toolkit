# Changelog

All notable changes to this project are documented here. The format is based
on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.1](https://github.com/fabiocicerchia/init-toolkit/compare/v0.2.0...v0.2.1) (2026-08-29)

### Bug Fixes

- unblock quality and clear the Scorecard pinned-dependencies finding ([#35](https://github.com/fabiocicerchia/init-toolkit/issues/35)) ([35bde26](https://github.com/fabiocicerchia/init-toolkit/commit/35bde26fa6f242d7246942efe5f3d32eafa2379f))

## [0.2.0](https://github.com/fabiocicerchia/init-toolkit/compare/v0.1.2...v0.2.0) (2026-08-25)

### Features

- **docs:** build the docs site in Actions and drop Read the Docs ([#32](https://github.com/fabiocicerchia/init-toolkit/issues/32)) ([488d65a](https://github.com/fabiocicerchia/init-toolkit/commit/488d65a6d38f4b5f3634af6151e78aae84d68127))

## [0.1.2](https://github.com/fabiocicerchia/init-toolkit/compare/v0.1.1...v0.1.2) (2026-08-13)

### Bug Fixes

- security and code-quality findings ([#27](https://github.com/fabiocicerchia/init-toolkit/issues/27)) ([7ddde7b](https://github.com/fabiocicerchia/init-toolkit/commit/7ddde7bac883c435d9dd64aba8250fe5cb0535ac))

## [0.1.1](https://github.com/fabiocicerchia/init-toolkit/compare/v0.1.0...v0.1.1) (2026-08-06)

### Bug Fixes

- **pre-commit:** stop check-yaml failing on Helm templates and multi-doc manifests ([7eac63d](https://github.com/fabiocicerchia/init-toolkit/commit/7eac63d587394a6a0202bb288c55a1a109e2354a))
- **security:** skip the SARIF upload on private repos ([64c844c](https://github.com/fabiocicerchia/init-toolkit/commit/64c844c14fcd6c8976ab62fdf58959bae1628302))

## [Unreleased]

## [0.1.0]

### Added

- `wait-for`: single front door for TCP/HTTP readiness checks.
- `wait-for-it` and `dockerize`, bundled unmodified from upstream.
- `healthcheck-http` / `healthcheck-tcp` one-line `HEALTHCHECK` probes.

[Unreleased]: https://github.com/fabiocicerchia/init-toolkit/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/fabiocicerchia/init-toolkit/releases/tag/v0.1.0

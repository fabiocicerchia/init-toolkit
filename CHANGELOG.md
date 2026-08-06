# Changelog

All notable changes to this project are documented here. The format is based
on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.1](https://github.com/fabiocicerchia/init-toolkit/compare/v0.1.0...v0.1.1) (2026-08-06)


### Bug Fixes

* **pre-commit:** stop check-yaml failing on Helm templates and multi-doc manifests ([7eac63d](https://github.com/fabiocicerchia/init-toolkit/commit/7eac63d587394a6a0202bb288c55a1a109e2354a))
* **security:** skip the SARIF upload on private repos ([64c844c](https://github.com/fabiocicerchia/init-toolkit/commit/64c844c14fcd6c8976ab62fdf58959bae1628302))

## [Unreleased]

## [0.1.0]

### Added

- `wait-for`: single front door for TCP/HTTP readiness checks.
- `wait-for-it` and `dockerize`, bundled unmodified from upstream.
- `healthcheck-http` / `healthcheck-tcp` one-line `HEALTHCHECK` probes.

[Unreleased]: https://github.com/fabiocicerchia/init-toolkit/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/fabiocicerchia/init-toolkit/releases/tag/v0.1.0

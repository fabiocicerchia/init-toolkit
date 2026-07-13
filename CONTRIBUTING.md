# Contributing

Thanks for taking the time to contribute to init-toolkit!

## Getting started

You need Docker (with buildx for multi-arch), `make`, and `shellcheck`.

1. Fork and clone the repo.
1. Install git hooks and dev tooling: `make setup` (wires up gitleaks + pre-commit).
1. Create a branch: `git checkout -b feat/short-description`.

```sh
make build   # build the image locally
make lint    # hadolint (Dockerfile) + shellcheck (bin/ + test.sh)
make test    # build + smoke test (./test.sh)
```

## Making changes

- Keep changes focused; one logical change per PR.
- Update `docs/` and `examples/` when behavior changes.
- Ensure CI (`code-quality` + `security`) passes.

Don't edit `CHANGELOG.md` or `version.txt` by hand — they're generated from
commit messages by release-please (see [Releases](#releases)).

## Commit messages

Use [Conventional Commits](https://www.conventionalcommits.org/): `feat:`,
`fix:`, `docs:`, `chore:`, etc. This keeps history readable and drives the
version bump: `fix:` → patch, `feat:` → minor, `feat!:` or a
`BREAKING CHANGE:` footer → major.

## Releases

Releases are automated by [release-please](.github/workflows/release.yml):

1. Merge `feat:`/`fix:` PRs into `main` as normal — **no tag is created**.
1. release-please keeps an open **release PR** ("chore: release X.Y.Z"),
   recalculating the next version and changelog on every merge.
1. Merging that release PR creates the `vX.Y.Z` tag and GitHub Release, which
   triggers the multi-arch image build and push to GHCR.

So `main` is not released per-commit: changes accumulate into the release PR,
and merging it is the deliberate release step.

## Pull requests

Fill out the PR template, link related issues, and request review. Be kind.

## License

By contributing you agree that your contributions are licensed under the
Apache License 2.0 (see `LICENSE`).

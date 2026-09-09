IMAGE     ?= fabiocicerchia/init-toolkit
VERSION   ?= $(shell cat version.txt)
PLATFORMS ?= linux/amd64,linux/arm64

# Every verb this repository exposes lives here; `make` on its own prints them.
# FC-GEN-057: the same eight verbs in every repo, each either wired or a
# declared no-op that says why. None of them exit 0 quietly.

.DEFAULT_GOAL := help

.PHONY: help setup install uninstall build test lint run format analyze push release

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  %-8s %s\n", $$1, $$2}'

setup: ## Install the pre-commit hook
	pre-commit install

build: ## Build the image locally
	docker build -t $(IMAGE):$(VERSION) .

lint: ## Run the whole gate — every hook, every file
	pre-commit run --all-files

test: build ## Build + run smoke tests
	./test.sh $(IMAGE):$(VERSION)

install: ## Install the tools and their man pages (DESTDIR/PREFIX honoured)
	install -d "$(DESTDIR)$(PREFIX)/bin" "$(DESTDIR)$(PREFIX)/share/man/man1"
	install -m 0755 bin/wait-for "$(DESTDIR)$(PREFIX)/bin/wait-for"
	install -m 0644 man/wait-for.1 "$(DESTDIR)$(PREFIX)/share/man/man1/wait-for.1"
	install -m 0755 bin/healthcheck-http "$(DESTDIR)$(PREFIX)/bin/healthcheck-http"
	install -m 0644 man/healthcheck-http.1 "$(DESTDIR)$(PREFIX)/share/man/man1/healthcheck-http.1"
	install -m 0755 bin/healthcheck-tcp "$(DESTDIR)$(PREFIX)/bin/healthcheck-tcp"
	install -m 0644 man/healthcheck-tcp.1 "$(DESTDIR)$(PREFIX)/share/man/man1/healthcheck-tcp.1"
	@echo "installed wait-for healthcheck-http healthcheck-tcp into $(DESTDIR)$(PREFIX)/bin"

uninstall: ## Remove what `make install` put down
	rm -f "$(DESTDIR)$(PREFIX)/bin/wait-for" "$(DESTDIR)$(PREFIX)/share/man/man1/wait-for.1" "$(DESTDIR)$(PREFIX)/bin/healthcheck-http" "$(DESTDIR)$(PREFIX)/share/man/man1/healthcheck-http.1" "$(DESTDIR)$(PREFIX)/bin/healthcheck-tcp" "$(DESTDIR)$(PREFIX)/share/man/man1/healthcheck-tcp.1"

run: build ## Run wait-for from the image (ARGS are its arguments)
	docker run --rm $(IMAGE):$(VERSION) $(ARGS)

format: ## Rewrite what the gate can fix: whitespace, line endings, final newline
	@# A fixing hook exits 1 when it rewrites a file. That is this target doing
	@# its job, not failing, so the exits are ignored — make still prints what
	@# each hook said.
	-pre-commit run --all-files trailing-whitespace
	-pre-commit run --all-files end-of-file-fixer
	-pre-commit run --all-files mixed-line-ending

analyze: ## Scan the tree the way CI does — vulnerabilities, misconfig, secrets
	@command -v trivy >/dev/null 2>&1 || { \
		echo "analyze needs trivy: https://trivy.dev/latest/getting-started/installation/" >&2; \
		exit 69; }
	trivy fs --scanners vuln,misconfig,secret --severity CRITICAL,HIGH .

push: build ## Push the single-arch image
	docker push $(IMAGE):$(VERSION)

release: ## Build + push multi-arch (usually done by CI)
	docker buildx build --platform $(PLATFORMS) \
		-t $(IMAGE):$(VERSION) -t $(IMAGE):latest --push .

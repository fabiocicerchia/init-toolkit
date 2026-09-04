IMAGE     ?= fabiocicerchia/init-toolkit
VERSION   ?= $(shell cat version.txt)
PLATFORMS ?= linux/amd64,linux/arm64

.PHONY: help setup build lint test push release

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  %-8s %s\n", $$1, $$2}'

setup: ## Install the pre-commit hook
	pre-commit install

build: ## Build the image locally
	docker build -t $(IMAGE):$(VERSION) .

lint: ## Lint Dockerfile (hadolint) + shell scripts (shellcheck)
	docker run --rm -i hadolint/hadolint < Dockerfile
	shellcheck bin/wait-for bin/healthcheck-http bin/healthcheck-tcp test.sh

test: build ## Build + run smoke tests
	./test.sh $(IMAGE):$(VERSION)

push: build ## Push the single-arch image
	docker push $(IMAGE):$(VERSION)

release: ## Build + push multi-arch (usually done by CI)
	docker buildx build --platform $(PLATFORMS) \
		-t $(IMAGE):$(VERSION) -t $(IMAGE):latest --push .

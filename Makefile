SHELL:=bash
.SHELLFLAGS:=-eu -o pipefail -c
MAKEFLAGS+=--warn-undefined-variables
MAKEFLAGS+=--no-builtin-rules

$(shell mkdir -p ~/.cache/bundle) # avoid permission issue with docker when non-existent directory is mounted

.DEFAULT_GOAL := help
.PHONY: help
help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

##
## Project setup
##---------------------------------------------------------------------------

.PHONY: start
start: .ssl/cert.crt deps ## Install and start the project
	docker compose pull --parallel --ignore-pull-failures
	docker compose up --remove-orphans

.PHONY: stop
stop: ## Remove docker containers, volumes, networks, etc.
	docker compose down --volumes --remove-orphans

.PHONY: reset
reset: stop start ## Clean-up and restart the whole project

.PHONY: clean
clean: stop
	rm -rf .ssl/ bundle/ _site/

##
## Utils
##---------------------------------------------------------------------------

.PHONY: build
build: ## Compile the website
	bin/app bundle exec jekyll build --drafts

.PHONY: draft
draft: ## Create a new draft defined by $DRAFT variable
	bin/app bundle exec octopress new draft $(DRAFT)

.PHONY: publish
publish: ## Publish draft defined by $DRAFT variable
	bin/app bundle exec octopress publish "_drafts/$(DRAFT)"
	@echo "Published date :\n"
	@php -r "echo date(DATE_ATOM);"

##
## Dependencies
##---------------------------------------------------------------------------

.PHONY: deps
deps: bundle ## Install the project dependencies

.PHONY: deps-update
deps-update: ## Update the project dependencies
	bin/app bundle update

##
# Internal rules
##

bundle: Gemfile.lock Gemfile
	bin/app bundle install
	@touch $@

Gemfile.lock: Gemfile
	@echo Gemfile.lock is not up to date.

.ssl/cert.crt:
	mkdir -p .ssl
	mkcert -cert-file .ssl/cert.crt \
		-key-file .ssl/private.key \
		bgalati.docker

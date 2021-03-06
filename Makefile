SHELL=/bin/bash

$(shell mkdir -p ~/.cache/bundle) # avoid permission issue with docker

RUN=docker-compose run --rm --no-deps app
EXEC=docker-compose exec app

.DEFAULT_GOAL := help

.PHONY: help

help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

##
## Project setup
##---------------------------------------------------------------------------

.PHONY: start stop reset clean

start: .ssl/cert.crt deps ## Install and start the project
	docker-compose pull --parallel --ignore-pull-failures
	docker-compose up --remove-orphans

stop: ## Remove docker containers, volumes, networks, etc.
	docker-compose down --volumes --remove-orphans

reset: stop start ## Clean-up and restart the whole project

clean: stop
	rm -rf .ssl/ bundle/ _site/

##
## Utils
##---------------------------------------------------------------------------

build: ## Compile the website
	$(EXEC) bundle exec jekyll build --drafts

draft: ## Create a new draft defined by $DRAFT variable
	$(EXEC) bundle exec octopress new draft ${DRAFT}

publish: ## Publish draft defined by $DRAFT variable
	$(EXEC) bundle exec octopress publish _drafts/${DRAFT}
	@echo "Published date :\n"
	@php -r "echo date(DATE_ATOM);"

##
## Dependencies
##---------------------------------------------------------------------------

.PHONY: deps

deps: bundle ## Install the project dependencies

.PHONY: bundle-update
deps-update: ## Update the project dependencies
	$(RUN) bundle update

##
# Internal rules
##

bundle: Gemfile.lock Gemfile
	$(RUN) bundle install
	@touch $@

Gemfile.lock: Gemfile
	@echo Gemfile.lock is not up to date.

.ssl/cert.crt:
	mkdir -p .ssl
	mkcert -cert-file .ssl/cert.crt \
		-key-file .ssl/private.key \
		bgalati.docker

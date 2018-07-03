SHELL=/bin/bash

$(shell mkdir -p bundle) # avoid permission issue with docker

export HOST_UID=$(shell id -u)
export HOST_GID=$(shell id -g)

DOCKER_COMPOSE?=docker-compose
RUN=$(DOCKER_COMPOSE) run --rm app
EXEC=$(DOCKER_COMPOSE) exec app

.DEFAULT_GOAL := help

.PHONY: help

help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

##
## Project setup
##---------------------------------------------------------------------------

.PHONY: start stop reset clean

start: .ssl/cert.crt deps ## Install and start the project
	$(DOCKER_COMPOSE) pull --parallel --ignore-pull-failures
	$(DOCKER_COMPOSE) up --remove-orphans --no-recreate

stop: ## Remove docker containers, volumes, networks, etc.
	$(DOCKER_COMPOSE) down --volumes --remove-orphans

reset: stop start ## Clean-up and restart the whole project

clean: stop
	rm -rf .ssl/cert.crt .ssl/private.key bundle/* _site/

##
## Utils
##---------------------------------------------------------------------------

build: # Compile the website
	$(EXEC) bundle exec jekyll build --drafts

draft: # Create a new draft defined by $DRAFT variable
	$(EXEC) bundle exec octopress new draft ${DRAFT}

publish: # Publish draft defined by $DRAFT variable
	$(EXEC) bundle exec octopress publish _drafts/${DRAFT}
	@echo "Published date :\n"
	@php -r "echo date(DATE_ATOM);"

##
## Dependencies
##---------------------------------------------------------------------------

.PHONY: deps

deps: bundle ## Install the project dependencies

##
# Internal rules
##

bundle: Gemfile.lock
	$(RUN) bundle install

Gemfile.lock: Gemfile
	@echo Gemfile.lock is not up to date.

.ssl/cert.crt:
	$(RUN) openssl req -x509 -nodes -newkey rsa:2048 -sha256 -keyout .ssl/private.key -out .ssl/cert.crt -subj "/CN=bgalati.docker" -days 3650

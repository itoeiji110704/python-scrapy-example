.DEFAULT_GOAL := help

# Define variables
project_tag = "$(shell basename `pwd`)-$(shell whoami)"
production_tag = "$(shell basename `pwd`)-prd"
staging_tag = "$(shell basename `pwd`)-stg"
develop_tag = "$(shell basename `pwd`)-dev"
commit_hash = $(shell git rev-parse --short HEAD)


# Show variables to debug
$(warning project_tag = $(project_tag))
$(warning production_tag = $(production_tag))
$(warning staging_tag = $(staging_tag))
$(warning develop_tag = $(develop_tag))
$(warning commit_hash = $(commit_hash))


.PHONY: build
build: ## Build the image
	@docker-compose \
	     --project-name $(project_tag) \
	     build \
	     --no-cache \


.PHONY: up
up: ## Up the container
	@docker-compose \
	     --project-name $(project_tag) \
	     up \
	     --detach


.PHONY: build-up
build-up: ## Build the image and up the container
	@docker-compose \
	     --project-name $(project_tag) \
	     build \
	     --no-cache
	@docker-compose \
	     --project-name $(project_tag) \
	     up \
	     --detach


.PHONY: login
login: ## Login to the container
	@docker-compose \
	     --project-name $(project_tag) \
	     exec main /bin/bash


.PHONY: help
help: ## Show all command descriptions
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	 awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

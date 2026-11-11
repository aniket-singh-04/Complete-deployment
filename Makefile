DOC_COM := docker compose
OS := $(shell uname -s)

.DEFAULT_GOAL := help

IMAGE_NAME ?= my_app
IMAGE_TAG ?= v1.0.0
CONTAINER_NAME ?= express-app
SERVICE ?= app

.PHONY: help build up up-build down restart logs ps status clean shell exec start stop start-container stop-container restart-container

help: ## Show available commands
	@echo "Operating System: $(OS)"
	@echo "Usage: make [target] [VARIABLE=value]"
	@echo ""
	@echo "Targets:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-18s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## Build Docker image
	IMAGE_NAME=$(IMAGE_NAME) IMAGE_TAG=$(IMAGE_TAG) CONTAINER_NAME=$(CONTAINER_NAME) $(DOC_COM) build

up: ## Start containers in detached mode
	IMAGE_NAME=$(IMAGE_NAME) IMAGE_TAG=$(IMAGE_TAG) CONTAINER_NAME=$(CONTAINER_NAME) $(DOC_COM) up -d

up-build: ## Build images and start containers
	IMAGE_NAME=$(IMAGE_NAME) IMAGE_TAG=$(IMAGE_TAG) CONTAINER_NAME=$(CONTAINER_NAME) $(DOC_COM) up -d --build

down: ## Stop and remove Compose containers
	$(DOC_COM) down

start: ## Start a stopped Compose service
	$(DOC_COM) start $(SERVICE)

stop: ## Stop a Compose service
	$(DOC_COM) stop $(SERVICE)

restart: ## Restart a Compose service
	$(DOC_COM) restart $(SERVICE)

start-container: ## Start a specific Docker container
	docker start $(CONTAINER_NAME)

stop-container: ## Stop a specific Docker container
	docker stop $(CONTAINER_NAME)

restart-container: ## Restart a specific Docker container
	docker restart $(CONTAINER_NAME)

logs: ## Follow real-time container logs
	$(DOC_COM) logs -f $(SERVICE)

ps: ## List containers and health status
	$(DOC_COM) ps

status: ps ## Alias for ps

clean: ## Remove containers, volumes, networks and orphans
	$(DOC_COM) down -v --remove-orphans

shell: ## Open an interactive shell inside a Compose service
	$(DOC_COM) exec $(SERVICE) sh

exec: ## Open an interactive shell inside a specific container
	docker exec -it $(CONTAINER_NAME) sh
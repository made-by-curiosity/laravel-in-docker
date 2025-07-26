# Makefile for managing Laravel Docker setup

# To use with prod: type commands like `make up ENV=prod`
ENV ?= dev
COMPOSE_FILE = docker-compose.$(ENV).yml

# 🐳 Docker Compose Commands

fresh-build:
	docker compose -f $(COMPOSE_FILE) build --no-cache

up:
	docker compose -f $(COMPOSE_FILE) up -d --build

down:
	docker compose -f $(COMPOSE_FILE) down

compose:
	docker compose -f $(COMPOSE_FILE) $(cmd)

# 🧰 Laravel Artisan

artisan:
	docker compose -f $(COMPOSE_FILE) run --rm artisan $(cmd)

migrate:
	docker compose -f $(COMPOSE_FILE) run --rm artisan migrate

generate-key:
	docker compose -f $(COMPOSE_FILE) run --rm artisan key:generate

# 📦 Composer

composer:
	docker compose -f $(COMPOSE_FILE) run --rm composer $(cmd)

composer-install:
	docker compose -f $(COMPOSE_FILE) run --rm composer install

# Fresh start

init: prepare-env fresh-build

prepare-env:
	@if [ ! -f .env ]; then \
		cp .env.example .env && \
		echo ".env created"; \
	else \
		echo ".env already exists"; \
	fi

laravel-init: prepare-laravel-env composer-install generate-key migrate

prepare-laravel-env:
	@if [ ! -f ./application/.env ]; then \
		cp ./application/.env.example ./application/.env && \
		echo "laravel .env created"; \
	else \
		echo "laravel .env already exists"; \
	fi

# Creating new project

# Ensure the application directory exists and has correct permissions
# we need it because when we start containers they use this directory as a volume and if it doesn't exist it is getting created as a root user
# which leads to permission issues when we try to access it from our user and we won't be able to create a new project inside it
prepare-new-project:
	@if [ -d "./application" ]; then \
		echo "Folder exists. Updating ownership..."; \
		sudo chown -R 1000:1000 ./application; \
	else \
		echo "Folder not found. Creating..."; \
		mkdir -p ./application; \
		sudo chown -R 1000:1000 ./application; \
	fi

create-project:
	docker compose -f $(COMPOSE_FILE) run --rm composer create-project laravel/laravel .

# restart containers after creating a new project to apply changes
new-project: prepare-new-project create-project

# info

show-config:
	docker compose -f $(COMPOSE_FILE) config
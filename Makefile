# Makefile for managing Laravel Docker setup

# 🐳 Docker Compose Commands

fresh-build:
	docker compose build --no-cache

up:
	docker compose up -d --build

down:
	docker compose down

compose:
	docker compose $(cmd)

# 🧰 Laravel Artisan

artisan:
	docker compose run --rm artisan $(cmd)

migrate:
	docker compose run --rm artisan migrate

generate-key:
	docker compose run --rm artisan key:generate

# 📦 Composer

composer:
	docker compose run --rm composer $(cmd)

composer-install:
	docker compose run --rm composer install

# Fresh start

init: prepare-env fresh-build

# To avoid issues with permissions we need to add UID and GID to the .env file, different servers may have different users, so this way we dynamically set them
prepare-env:
	@if [ ! -f .env ]; then \
		cp .env.example .env && \
		echo "UID=$$(id -u)" >> .env && \
		echo "GID=$$(id -g)" >> .env && \
		echo ".env created with UID and GID"; \
	else \
		echo ".env already exists"; \
		echo "" >> .env && \
		grep -q '^UID=' .env || echo "UID=$$(id -u)" >> .env; \
		grep -q '^GID=' .env || echo "GID=$$(id -g)" >> .env; \
		echo "UID/GID appended if missing"; \
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
		echo "Folder exists. Deleting..."; \
		sudo rm -rf ./application; \
	fi; \
	echo "Creating new folder..."; \
	mkdir -p ./application; \
	sudo chown -R 1000:1000 ./application;

create-project:
	docker compose run --rm composer create-project laravel/laravel .

# restart containers after creating a new project to apply changes
new-project: prepare-new-project create-project

# info

show-config:
	docker compose config
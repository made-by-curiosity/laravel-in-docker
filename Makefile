# Makefile for managing Laravel Docker setup

# To use with prod: type commands like `make up ENV=prod`
ENV ?= dev
COMPOSE_FILE = docker-compose.$(ENV).yml

# 🐳 Docker Compose Commands

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

# 📦 Composer

composer:
	docker compose -f $(COMPOSE_FILE) run --rm composer $(cmd)
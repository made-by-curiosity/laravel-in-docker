1. Git clone this project
2. Clone .env.example to .env and fill it with your data
3. Run ```docker compose up -d``` to run all containers
4. Run ```docker compose run --rm composer create-project laravel/laravel .``` to create laravel project that will appear in application folder
5. To execute composer commands run ```docker compose run --rm composer your_command```
6. To execute artisan commands run ```docker compose run --rm artisan your_command```
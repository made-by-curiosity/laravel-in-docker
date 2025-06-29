1. Git clone this project
2. Clone .env.example to .env and fill it with your data
3. Run ```docker compose -f docker-compose.dev.yml up -d``` to run all containers specifying dev or prod file
4. Run ```docker compose -f docker-compose.dev.yml run --rm composer create-project laravel/laravel .``` to create laravel project that will appear in application folder
5. To execute composer commands run ```docker compose -f docker-compose.dev.yml run --rm composer your_command```
6. To execute artisan commands run ```docker compose -f docker-compose.dev.yml run --rm artisan your_command```
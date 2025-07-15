To run this project you need Docker and Docker Compose installed. Also to execute shorter commands you'll need to use `make`. List of example commands you can find in Makefile. 

To run this project in production change ENV variable to `prod` in Makefile.

1. Git clone this project
2. Clone .env.example to .env and fill it with your data
3. Run ```docker compose -f docker-compose.dev.yml up -d``` to run all containers specifying dev or prod file
4. Run ```docker compose -f docker-compose.dev.yml run --rm composer create-project laravel/laravel .``` to create laravel project that will appear in application folder
5. Run db migrations ```docker compose -f docker-compose.dev.yml run --rm artisan migrate``` or ```make migrate```
6. To execute composer commands run ```docker compose -f docker-compose.dev.yml run --rm composer your_command```
7. To execute artisan commands run ```docker compose -f docker-compose.dev.yml run --rm artisan your_command```
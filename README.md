To run this project you need Docker and Docker Compose installed. Also to execute shorter commands you'll need to use `make`. List of example commands you can find in Makefile. 

1. Git clone this project.
2. Clone .env.example to .env and fill it with your data. Then build containers.
   Run ```make init``` or make it manually: 
   - ```cp .env.example .env```
   - ```docker compose build --no-cache```
3. Run ```make new-project``` to create laravel project that will appear in application folder, make sure           application folder has right ownership as a non-root user
4. Run ```make up``` to run all containers or ```docker compose up -d --build```
5. Run init commands for laravel ```make laravel-init``` or execute commands manually one by one:
   - ```cp ./application/.env.example ./application/.env```
   - ```docker compose run --rm composer install```
   - ```docker compose run --rm artisan key:generate```
   - ```docker compose run --rm artisan migrate```
6. Laravel app is available on localhost:8888 (<-- default port, if you changed it in .env, then use the one you changed it for)
7. After a fresh build use only ```make up``` and ```make down``` to run and stop the project


- To execute composer commands run ```make compose cmd="your command"``` or ```docker compose --rm composer your_command```
- To execute artisan commands run ```make artisan cmd="your command"``` or ```docker compose --rm artisan your_command```
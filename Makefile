NAME = inception
LOGIN = micha
DATA_PATH = /home/$(LOGIN)/data

all: up

up:
	@mkdir -p $(DATA_PATH)/mariadb
	@mkdir -p $(DATA_PATH)/wordpress
	docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	docker compose -f ./srcs/docker-compose.yml down

clean: down
	docker system prune -a -f

fclean: clean
	rm -rf $(DATA_PATH)
	docker volume rm $$(docker volume ls -q) 2>/dev/null || true

re: fclean all

.PHONY: all up down clean fclean re
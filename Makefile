start:
		@docker-compose stop
		@docker-compose up

up:
		@docker-compose up -d

req:
		@docker-compose exec web bundle install

shell:
		@docker-compose exec web rails console

seed:
		@docker-compose exec web rake db:seed

stop:
		@docker-compose stop

flush:
		@docker-compose exec web rake db:reset

drop:
		@docker-compose exec web rake db:drop

rm:
		@docker-compose stop
		@docker-compose rm -f
		@docker volume prune -f

create_db:
		@docker-compose exec web rake db:create
		@docker-compose exec web rake db:migrate

init:
		$(MAKE) up
		$(MAKE) req

reset:
		$(MAKE) stop
		$(MAKE) rm
		$(MAKE) drop
		$(MAKE) init
		$(MAKE) create_db
		$(MAKE) seed
		$(MAKE) start

start:
		@docker-compose stop
		@docker-compose up

up:
		@docker-compose up -d

req:
		@docker-compose exec web bundle install

bash:
		@docker-compose exec web bash

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

migrate:
		@docker-compose exec web rake db:migrate

create_db:
		@docker-compose exec web rake db:create
		$(MAKE) migrate

tests:
		@docker-compose exec web rake db:migrate RAILS_ENV=test
		@docker-compose exec web rake db:seed RAILS_ENV=test
		@docker-compose exec web cucumber

init:
		$(MAKE) up
		$(MAKE) req

reset:
		$(MAKE) stop
		$(MAKE) rm
		$(MAKE) init
		$(MAKE) create_db
		$(MAKE) seed
		$(MAKE) start

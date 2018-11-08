start:
		@docker-compose stop
		@docker-compose up

up:
		@docker-compose up -d

req:
		bundle install

shell:
		@docker-compose run web rails console

seed:
		@docker-compose run web rake db:seed

stop:
		@docker-compose stop

flush:
		@docker-compose run web rake db:reset

drop:
		@docker-compose run web rake db:drop

rm:
		@docker-compose stop
		@docker-compose rm -f
		@docker volume prune -f

create_db:
		@docker-compose run web rake db:create
		@docker-compose run web rake db:migrate

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

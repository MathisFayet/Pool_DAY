drop_database:
	mix ecto.drop
	mix ecto.create

migration:
	mix ecto.migrate

run:
	mix phx.server

seed:
	mix run priv/repo/seeds.exs

get_deps:
	mix deps.get

reset:
	make drop_database
	make migration
	make seed

.phony:
	seed run migration drop_database get_deps reset
drop_database:
	mix ecto.drop

migration:
	mix ecto.migrate

run:
	mix phx.server

seed:
	mix run priv/repo/seeds.exs

get_deps:
	mix deps.get

.phony:
	seed run migration drop_database get_deps
defmodule Schemas.Schedules do
  use Ecto.Schema

  schema "schedules" do
    field :arrival, :utc_datetime_usec
    field :departure, :utc_datetime_usec
  end
end

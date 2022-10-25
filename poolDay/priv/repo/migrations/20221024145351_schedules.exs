defmodule PoolDay.Repo.Migrations.Schedules do
  use Ecto.Migration

  def change do
    create table("schedules") do
      add(:arrival, :utc_datetime_usec)
      add(:departure, :utc_datetime_usec)

      timestamps()
    end
  end
end

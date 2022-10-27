defmodule TimeManager.Repo.Migrations.CreateWorkingtimes do
  use Ecto.Migration

  def change do
    create table(:workingtimes) do
      add :start, :utc_datetime_usec, null: false
      add :end, :utc_datetime_usec, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:workingtimes, [:start])
    create index(:workingtimes, [:end])
    create index(:workingtimes, [:user_id])
  end
end

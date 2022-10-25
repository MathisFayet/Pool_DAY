defmodule TimeManager.Repo.Migrations.CreateClocks do
  use Ecto.Migration

  def change do
    create table(:clocks) do
      add :time, :utc_datetime_usec, null: false
      add :status, :boolean, default: false, null: false
      add :user, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:clocks, [:time])
    create index(:clocks, [:status])
    create index(:clocks, [:user])
  end
end

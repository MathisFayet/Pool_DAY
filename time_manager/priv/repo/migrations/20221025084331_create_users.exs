defmodule TimeManager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :email, :string, null: false

      timestamps()
    end

    create index(:users, [:username], unique: true)
    create index(:users, [:email], unique: true)

  end
end

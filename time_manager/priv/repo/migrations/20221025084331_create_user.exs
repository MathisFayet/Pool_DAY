defmodule TimeManager.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :username, :string, null: false
      add :email, :string, null: false

      timestamps()
    end
  end
end

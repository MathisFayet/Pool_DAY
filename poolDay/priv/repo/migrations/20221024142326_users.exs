defmodule PoolDay.Repo.Migrations.Users do
  use Ecto.Migration

  def change do
    create table("users") do
      add(:first_name, :string, size: 255)
      add(:last_name, :string, size: 255)
      add(:email, :string, size: 255)
      add(:password, :string, size: 255)
      add(:role, :int)

      timestamps()
    end
  end
end

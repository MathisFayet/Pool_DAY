defmodule PoolDay.Repo.Migrations.Teams do
  use Ecto.Migration

  def change do
    add(:users, :users) ## TODO :: One-to-many
    add(:managers, :managers) ## TODO :: One-to-many
    add(:general_manager, :user) ## TODO :: One-to-one

  end
end



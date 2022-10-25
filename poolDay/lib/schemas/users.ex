defmodule Schemas.Users do
  use Ecto.Schema

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :password, :string
    field :role, :integer
  end
end

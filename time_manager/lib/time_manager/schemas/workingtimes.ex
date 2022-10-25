defmodule TimeManager.Schemas.Workingtimes do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workingtimes" do
    field :end, :utc_datetime_usec
    field :start, :utc_datetime_usec
    field :user, :id

    timestamps()
  end

  @doc false
  def changeset(workingtimes, attrs) do
    workingtimes
    |> cast(attrs, [:start, :end])
    |> validate_required([:start, :end])
  end
end

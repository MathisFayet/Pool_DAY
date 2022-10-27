defmodule TimeManager.Clock do
  @moduledoc """
  The Clock context.
  """

  import Ecto.Query, warn: false
  alias TimeManager.Repo
  alias TimeManager.Accounts.User
  alias TimeManager.WorkingTimes.WorkingTime

  alias TimeManager.Clock.Clocks

  @doc """
  Returns the list of clocks.

  ## Examples

      iex> list_clocks()
      [%Clocks{}, ...]

  """
  def list_clocks do
    Repo.all(Clocks)
  end

  @doc """
  Gets a single clocks.

  Raises `Ecto.NoResultsError` if the Clocks does not exist.

  ## Examples

      iex> get_clocks!(123)
      %Clocks{}

      iex> get_clocks!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clocks!(id), do: Repo.get!(Clocks, id)

  @doc """
  Gets a single clocks by user id.

  Raises `Ecto.NoResultsError` if the Clocks does not exist.

  ## Examples

      iex> get_clocks_by_userId!(123)
      %Clocks{}

      iex> get_clocks_by_userId!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clocks_by_userId!(userId) do
    q = from clock in Clocks, where: clock.user_id == ^userId
    Repo.all(q)
  end

  @doc """
  Do a clock in by user id.

  ## Examples

      iex> do_clocks_by_user_id!(123)
      %Clocks{}

      iex> do_clocks_by_user_id!(456)

  """
  def do_clocks_by_user_id(userId, status, oldClock) do
    clock_time = DateTime.utc_now()
    if(status == false and oldClock != nil) do
      working_time = %WorkingTime{
        user_id: userId,
        start: oldClock.time,
        end: clock_time,
      }
      Repo.insert!(working_time)
    end
    attrs = %{time: clock_time, user_id: userId, status: status}

    %Clocks{}
    |> Clocks.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Get the last clock by user id.

  ## Examples

      iex> get_last_clocks_by_user_id(123)
      %Clocks{}

      iex> get_last_clocks_by_user_id(456)

  """
  def get_last_clocks_by_user_id(userId) do
    Repo.one(from clock in TimeManager.Clock.Clocks, order_by: fragment("? DESC", clock.inserted_at), where: clock.user_id == ^userId, limit: 1)
  end


  @doc """
  Creates a clocks.

  ## Examples

      iex> create_clocks(%{field: value})
      {:ok, %Clocks{}}

      iex> create_clocks(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_clocks(attrs \\ %{}, userId) do
    %Clocks{}
    |> Clocks.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a clocks.

  ## Examples

      iex> update_clocks(clocks, %{field: new_value})
      {:ok, %Clocks{}}

      iex> update_clocks(clocks, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clocks(%Clocks{} = clocks, attrs) do
    clocks
    |> Clocks.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a clocks.

  ## Examples

      iex> delete_clocks(clocks)
      {:ok, %Clocks{}}

      iex> delete_clocks(clocks)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clocks(%Clocks{} = clocks) do
    Repo.delete(clocks)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clocks changes.

  ## Examples

      iex> change_clocks(clocks)
      %Ecto.Changeset{data: %Clocks{}}

  """
  def change_clocks(%Clocks{} = clocks, attrs \\ %{}) do
    Clocks.changeset(clocks, attrs)
  end
end

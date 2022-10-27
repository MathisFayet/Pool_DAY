defmodule TimeManager.WorkingTimes do
  @moduledoc """
  The WorkingTimes context.
  """

  import Ecto.Query, warn: false
  alias TimeManager.Repo

  alias TimeManager.WorkingTimes.WorkingTime

  @doc """
  Returns the list of workingtimes.

  ## Examples

      iex> list_workingtimes()
      [%WorkingTime{}, ...]

  """
  def list_workingtimes do
    Repo.all(WorkingTime)
  end

  @doc """
  Gets a single working_time.

  Raises `Ecto.NoResultsError` if the Working time does not exist.

  ## Examples

      iex> get_working_time!(123)
      %WorkingTime{}

      iex> get_working_time!(456)
      ** (Ecto.NoResultsError)

  """
  def get_working_time!(id) do
    Repo.get!(WorkingTime, id)
  end

  @doc """
  Gets a single working_time by userId.

  Raises `Ecto.NoResultsError` if the Working time does not exist.

  ## Examples

      iex> get_working_time_by_user_id!(123)
      %WorkingTime{}

      iex> get_working_time_by_user_id!(456)
      ** (Ecto.NoResultsError)

  """
  def get_working_time_by_user_id!(userId, startDate, endDate) do

    cond do
      startDate == nil and endDate == nil ->
        q = from wkTm in WorkingTime, where: wkTm.user_id == ^userId
        Repo.all(q)
      startDate == nil and endDate != nil ->
        q = from wkTm in WorkingTime, where: wkTm.user_id == ^userId and wkTm.end <= ^endDate
        Repo.all(q)
      startDate != nil and endDate == nil ->
        q = from wkTm in WorkingTime, where: wkTm.user_id == ^userId and wkTm.start >= ^startDate
        Repo.all(q)
      startDate != nil and endDate != nil ->
        q = from wkTm in WorkingTime, where: wkTm.user_id == ^userId and wkTm.start >= ^startDate and wkTm.end <= ^endDate
        Repo.all(q)
    end
  end

  @doc """
  Gets a single working_time by userId and by id.

  Raises `Ecto.NoResultsError` if the Working time does not exist.

  ## Examples

      iex> get_working_time_by_user_id_and_id!(123, 123)
      %WorkingTime{}

      iex> get_working_time_by_user_id_and_id!(456, 456)
      ** (Ecto.NoResultsError)

  """
  def get_working_time_by_user_id_and_id!(userId, id) do
    q = from wkTm in WorkingTime, where: wkTm.user_id == ^userId and wkTm.id == ^id
    Repo.all(q)
  end

  @doc """
  Creates a working_time.

  ## Examples

      iex> create_working_time(%{field: value})
      {:ok, %WorkingTime{}}

      iex> create_working_time(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_working_time(attrs \\ %{}) do
    %WorkingTime{}
    |> WorkingTime.changeset(attrs)
    |>Repo.insert()
  end

  @doc """
  Updates a working_time.

  ## Examples

      iex> update_working_time(working_time, %{field: new_value})
      {:ok, %WorkingTime{}}

      iex> update_working_time(working_time, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_working_time(%WorkingTime{} = working_time, attrs) do
    working_time
    |> WorkingTime.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a working_time.

  ## Examples

      iex> delete_working_time(working_time)
      {:ok, %WorkingTime{}}

      iex> delete_working_time(working_time)
      {:error, %Ecto.Changeset{}}

  """
  def delete_working_time(%WorkingTime{} = working_time) do
    Repo.delete(working_time)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking working_time changes.

  ## Examples

      iex> change_working_time(working_time)
      %Ecto.Changeset{data: %WorkingTime{}}

  """
  def change_working_time(%WorkingTime{} = working_time, attrs \\ %{}) do
    WorkingTime.changeset(working_time, attrs)
  end
end

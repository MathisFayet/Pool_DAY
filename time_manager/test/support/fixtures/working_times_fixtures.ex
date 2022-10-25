defmodule TimeManager.WorkingTimesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.WorkingTimes` context.
  """

  @doc """
  Generate a working_time.
  """
  def working_time_fixture(attrs \\ %{}) do
    {:ok, working_time} =
      attrs
      |> Enum.into(%{
        end: ~U[2022-10-24 14:24:00.000000Z],
        start: ~U[2022-10-24 14:24:00.000000Z]
      })
      |> TimeManager.WorkingTimes.create_working_time()

    working_time
  end
end

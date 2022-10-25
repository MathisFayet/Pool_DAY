defmodule TimeManager.ClockFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.Clock` context.
  """

  @doc """
  Generate a clocks.
  """
  def clocks_fixture(attrs \\ %{}) do
    {:ok, clocks} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~U[2022-10-24 14:05:00.000000Z]
      })
      |> TimeManager.Clock.create_clocks()

    clocks
  end
end

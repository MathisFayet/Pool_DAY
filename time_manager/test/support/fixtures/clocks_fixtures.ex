defmodule TimeManager.ClocksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.Clocks` context.
  """

  @doc """
  Generate a clocks.
  """
  def clocks_fixture(attrs \\ %{}) do
    {:ok, clocks} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~U[2022-10-24 13:57:00.000000Z]
      })
      |> TimeManager.Clocks.create_clocks()

    clocks
  end

  @doc """
  Generate a clocks.
  """
  def clocks_fixture(attrs \\ %{}) do
    {:ok, clocks} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~U[2022-10-24 14:03:00.000000Z]
      })
      |> TimeManager.Clocks.create_clocks()

    clocks
  end
end

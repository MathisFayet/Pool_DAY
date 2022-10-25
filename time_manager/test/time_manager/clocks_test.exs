defmodule TimeManager.ClocksTest do
  use TimeManager.DataCase

  alias TimeManager.Clocks

  describe "clocks" do
    alias TimeManager.Clocks.Schemas.Clocks

    import TimeManager.ClocksFixtures

    @invalid_attrs %{status: nil, time: nil}

    test "list_clocks/0 returns all clocks" do
      clocks = clocks_fixture()
      assert Clocks.list_clocks() == [clocks]
    end

    test "get_clocks!/1 returns the clocks with given id" do
      clocks = clocks_fixture()
      assert Clocks.get_clocks!(clocks.id) == clocks
    end

    test "create_clocks/1 with valid data creates a clocks" do
      valid_attrs = %{status: true, time: ~U[2022-10-24 13:57:00.000000Z]}

      assert {:ok, %Clocks{} = clocks} = Clocks.create_clocks(valid_attrs)
      assert clocks.status == true
      assert clocks.time == ~U[2022-10-24 13:57:00.000000Z]
    end

    test "create_clocks/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Clocks.create_clocks(@invalid_attrs)
    end

    test "update_clocks/2 with valid data updates the clocks" do
      clocks = clocks_fixture()
      update_attrs = %{status: false, time: ~U[2022-10-25 13:57:00.000000Z]}

      assert {:ok, %Clocks{} = clocks} = Clocks.update_clocks(clocks, update_attrs)
      assert clocks.status == false
      assert clocks.time == ~U[2022-10-25 13:57:00.000000Z]
    end

    test "update_clocks/2 with invalid data returns error changeset" do
      clocks = clocks_fixture()
      assert {:error, %Ecto.Changeset{}} = Clocks.update_clocks(clocks, @invalid_attrs)
      assert clocks == Clocks.get_clocks!(clocks.id)
    end

    test "delete_clocks/1 deletes the clocks" do
      clocks = clocks_fixture()
      assert {:ok, %Clocks{}} = Clocks.delete_clocks(clocks)
      assert_raise Ecto.NoResultsError, fn -> Clocks.get_clocks!(clocks.id) end
    end

    test "change_clocks/1 returns a clocks changeset" do
      clocks = clocks_fixture()
      assert %Ecto.Changeset{} = Clocks.change_clocks(clocks)
    end
  end

  describe "clocks" do
    alias TimeManager.Clocks.Schemas.Clocks

    import TimeManager.ClocksFixtures

    @invalid_attrs %{status: nil, time: nil}

    test "list_clocks/0 returns all clocks" do
      clocks = clocks_fixture()
      assert Clocks.list_clocks() == [clocks]
    end

    test "get_clocks!/1 returns the clocks with given id" do
      clocks = clocks_fixture()
      assert Clocks.get_clocks!(clocks.id) == clocks
    end

    test "create_clocks/1 with valid data creates a clocks" do
      valid_attrs = %{status: true, time: ~U[2022-10-24 14:03:00.000000Z]}

      assert {:ok, %Clocks{} = clocks} = Clocks.create_clocks(valid_attrs)
      assert clocks.status == true
      assert clocks.time == ~U[2022-10-24 14:03:00.000000Z]
    end

    test "create_clocks/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Clocks.create_clocks(@invalid_attrs)
    end

    test "update_clocks/2 with valid data updates the clocks" do
      clocks = clocks_fixture()
      update_attrs = %{status: false, time: ~U[2022-10-25 14:03:00.000000Z]}

      assert {:ok, %Clocks{} = clocks} = Clocks.update_clocks(clocks, update_attrs)
      assert clocks.status == false
      assert clocks.time == ~U[2022-10-25 14:03:00.000000Z]
    end

    test "update_clocks/2 with invalid data returns error changeset" do
      clocks = clocks_fixture()
      assert {:error, %Ecto.Changeset{}} = Clocks.update_clocks(clocks, @invalid_attrs)
      assert clocks == Clocks.get_clocks!(clocks.id)
    end

    test "delete_clocks/1 deletes the clocks" do
      clocks = clocks_fixture()
      assert {:ok, %Clocks{}} = Clocks.delete_clocks(clocks)
      assert_raise Ecto.NoResultsError, fn -> Clocks.get_clocks!(clocks.id) end
    end

    test "change_clocks/1 returns a clocks changeset" do
      clocks = clocks_fixture()
      assert %Ecto.Changeset{} = Clocks.change_clocks(clocks)
    end
  end
end

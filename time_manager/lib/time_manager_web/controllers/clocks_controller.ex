defmodule TimeManagerWeb.ClocksController do
  use TimeManagerWeb, :controller

  alias TimeManager.Clock
  alias TimeManager.Clock.Clocks

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    clocks = Clock.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, %{"userID" => userId}) do
    lastClock = Clock.get_last_clocks_by_user_id(userId)

    cond do
      lastClock == nil or (lastClock != nil and lastClock.status == false) ->
        with {:ok, %Clocks{} = clocks} <- Clock.do_clocks_by_user_id(String.to_integer(userId), true, nil, nil) do
          conn
          |> put_status(:created)
          |> put_resp_header("location", Routes.clocks_path(conn, :show, clocks))
          |> render("show.json", clocks: clocks)
        end
      lastClock != nil and lastClock.status == true ->

        with {:ok, %Clocks{} = clocks} <- Clock.do_clocks_by_user_id(String.to_integer(userId), false, lastClock, nil) do
          conn
          |> put_status(:created)
          |> put_resp_header("location", Routes.clocks_path(conn, :show, clocks))
          |> render("show.json", clocks: clocks)
        end
    end
  end

  def show(conn, %{"userID" => userId}) do
    clocks = Clock.get_clocks_by_userId!(userId)
    render(conn, "index.json", clocks: clocks)

  end

  def showLast(conn, %{"userID" => userId}) do
    clocks = Clock.get_last_clocks_by_user_id(userId)
    render(conn, "show.json", clocks: clocks)
  end

  def update(conn, %{"id" => id, "clocks" => clocks_params}) do
    clocks = Clock.get_clocks!(id)

    with {:ok, %Clocks{} = clocks} <- Clock.update_clocks(clocks, clocks_params) do
      render(conn, "show.json", clocks: clocks)
    end
  end

  def delete(conn, %{"id" => id}) do
    clocks = Clock.get_clocks!(id)

    with {:ok, %Clocks{}} <- Clock.delete_clocks(clocks) do
      send_resp(conn, :no_content, "")
    end
  end
end

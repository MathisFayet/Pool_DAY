defmodule PoolDayWeb.PageController do
  use PoolDayWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

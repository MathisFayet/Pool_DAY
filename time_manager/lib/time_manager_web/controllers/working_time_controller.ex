defmodule TimeManagerWeb.WorkingTimeController do
  use TimeManagerWeb, :controller

  alias TimeManager.WorkingTimes
  alias TimeManager.WorkingTimes.WorkingTime
  alias TimeManager.Accounts

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, params) do
    userId = Map.get(params, "userID", nil)
    startDateStr = Map.get(params, "start", nil)
    endDateStr = Map.get(params, "end", nil)
    formatDateStr = "%Y%m%d%H%M%S"
    startDate =
      if startDateStr != nil do
        Timex.parse!(startDateStr, formatDateStr, :strftime)
      else
        nil
      end

    endDate =
      if(endDateStr != nil) do
        Timex.parse!(endDateStr, formatDateStr, :strftime)
      else
        nil
      end

    workingtimes = WorkingTimes.get_working_time_by_user_id!(userId, startDate, endDate)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"userID" => userId, "working_time" => working_time_params}) do
    formatDateStr = "%Y-%m-%d %H:%M:%S"
    endDate = Timex.parse!(Map.get(working_time_params, "end", nil), formatDateStr, :strftime)
    startDate = Timex.parse!(Map.get(working_time_params, "start", nil), formatDateStr, :strftime)
    _user = Accounts.get_user!(userId)

    working_time_params = Map.put(working_time_params, "end", endDate)
    working_time_params = Map.put(working_time_params, "start", startDate)
    working_time_params = Map.put(working_time_params, "user_id", userId)

    with {:ok, %WorkingTime{} = working_time} <-
           WorkingTimes.create_working_time(working_time_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.working_time_path(conn, :show, working_time, userId))
      |> render("show.json", working_time: working_time)
    end
  end

  def show(conn, %{"userID" => userId, "id" => id}) do
    workingtimes = WorkingTimes.get_working_time_by_user_id_and_id!(userId, id)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def update(conn, %{"id" => id, "working_time" => working_time_params}) do
    working_time = WorkingTimes.get_working_time!(id)

    with {:ok, %WorkingTime{} = working_time} <-
           WorkingTimes.update_working_time(working_time, working_time_params) do
      render(conn, "show.json", working_time: working_time)
    end
  end

  def delete(conn, %{"id" => id}) do
    working_time = WorkingTimes.get_working_time!(id)

    with {:ok, %WorkingTime{}} <- WorkingTimes.delete_working_time(working_time) do
      send_resp(conn, :no_content, "")
    end
  end
end

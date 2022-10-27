defmodule APIWeb.WorkingtimeController do
  use APIWeb, :controller

  alias API.Schema
  alias API.Schema.Workingtime

  action_fallback APIWeb.FallbackController

  def index(conn, _params) do
    workingtimes = Schema.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def createOne(conn, %{"userid" => userid, "workingtime" => workingtime_params}) do
    {status, workingtime} = Schema.create_workingtime(userid, workingtime_params)
    IO.inspect(workingtime)
    json(conn, workingtime)
  end

  def getByParams(conn, %{"userid" => userid, "id" => id}) do
    workingtime = Schema.getUser(userid, id)
    json(conn, workingtime)
  end

  def getItemByAllParams(conn, %{"userid" => userid, "start" => start, "end" => endDate}) do
    workingtime = Schema.getUserByAllParams(userid, start, endDate)
    json(conn, workingtime)
  end

  def show(conn, %{"id" => id, "start" => start, "end" => endDate}) do
    workingtime = Schema.getUserByAllParams(id, start, endDate)
    json(conn, workingtime)
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = Schema.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- Schema.update_workingtime(workingtime, workingtime_params) do
      json(conn, workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = Schema.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Schema.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end
end

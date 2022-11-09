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
    try do
      {status, workingtime} = Schema.create_workingtime(userid, workingtime_params)
      IO.inspect(workingtime)
      json(conn, workingtime)
    rescue
      e in Ecto.ConstraintError -> render(conn, "error.json", message: "WorkingTime with User #{userid} already exist")
    end
  end

  def getByParams(conn, %{"userid" => userid, "id" => id}) do
    try do
      if id == nil do
        workingtime = Schema.getByUserid(userid)
        json(conn, workingtime)
      else
        workingtime = Schema.getUser(userid, id)
        json(conn, workingtime)
      end
    rescue
      e in Ecto.NoResultsError -> render(conn, "error.json", message: "Workingtime doesn't exist")
    end
  end

  def getWorkingtimeByUserid(conn, %{"userid" => userid}) do
    try do
      workingtime = Schema.getByUserid(userid)
      json(conn, workingtime)
    rescue
      e in Ecto.NoResultsError -> render(conn, "error.json", message: "User doesn't exist")
    end
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
    try do
      workingtime = Schema.get_workingtime!(id)
      with {:ok, %Workingtime{} = workingtime} <- Schema.update_workingtime(workingtime, workingtime_params) do
        json(conn, workingtime)
      end
    rescue
      e in Ecto.NoResultsError -> render(conn, "error.json", message: "Workingtime doesn't exists")
    end
  end

  def delete(conn, %{"id" => id}) do
    try do
      workingtime = Schema.get_workingtime!(id)
      with {:ok, %Workingtime{}} <- Schema.delete_workingtime(workingtime) do
        send_resp(conn, :no_content, "")
      end
    rescue
      e in Ecto.NoResultsError -> render(conn, "error.json", message: "Workingtime doesn't exists")
    end
  end
end

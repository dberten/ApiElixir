defmodule TodolistWeb.WorkingtimeController do
  use TodolistWeb, :controller

  alias Todolist.Schema
  alias Todolist.Schema.Workingtime

  action_fallback TodolistWeb.FallbackController

  def index(conn, _params) do
    workingtimes = Schema.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def createOne(conn, %{"userid" => userid, "workingtime" => workingtime_params}) do
    {status, workingtime} = Schema.create_workingtime(userid, workingtime_params)
    json(conn, workingtime)
  end

  def getByParams(conn, %{"userid" => userid, "id" => id}) do
    workingtime = Schema.getUser(userid, id)
    json(conn, workingtime)
  end

  def show(conn, %{"id" => id}) do
    workingtime = Schema.get_workingtime!(id)
    render(conn, "show.json", workingtime: workingtime)
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = Schema.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- Schema.update_workingtime(workingtime, workingtime_params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = Schema.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Schema.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end
end

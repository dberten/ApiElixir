defmodule TodolistWeb.ClockController do
  use TodolistWeb, :controller

  alias Todolist.Schema
  alias Todolist.Schema.Clock

  action_fallback TodolistWeb.FallbackController

  def index(conn, _params) do
    clocks = Schema.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def createOneClock(conn, %{"userid" => userid, "clock" => clock_params}) do
    {status, clock} = Schema.create_OneClock(userid, clock_params)
    json(conn, clock)
  end

  def show(conn, %{"id" => id}) do
    clock = Schema.get_clock!(id)
    render(conn, "show.json", clock: clock)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Schema.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Schema.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Schema.get_clock!(id)

    with {:ok, %Clock{}} <- Schema.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
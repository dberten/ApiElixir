defmodule APIWeb.ClockController do
  use APIWeb, :controller

  alias API.Schema
  alias API.Schema.Clock

  action_fallback APIWeb.FallbackController

  def index(conn, _params) do
    clocks = Schema.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def createOneClock(conn, %{"userid" => userid, "clock" => clock_params}) do
    try do
      {status, clock} = Schema.create_OneClock(userid, clock_params)
      IO.inspect(clock)
      json(conn, clock)
    rescue
      e in Ecto.ConstraintError -> render(conn, "error.json", message: "User #{userid} doesn't exists")
    end
  end

  def show(conn, %{"id" => id}) do
    try do
      clock = Schema.get_clock_by_userid(id)
      json(conn, clock)
    rescue
      e in Ecto.NoResultsError -> render(conn, "error.json", message: "User #{id} doesn't exists")
    end
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

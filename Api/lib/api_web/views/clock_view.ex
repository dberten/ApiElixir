defmodule APIWeb.ClockView do
  use APIWeb, :view
  alias APIWeb.ClockView

  def render("index.json", %{clocks: clocks}) do
    %{data: render_many(clocks, ClockView, "clock.json")}
  end

  def render("show.json", %{clock: clock}) do
    %{data: render_one(clock, ClockView, "clock.json")}
  end

  def rend("success.json", %{message: message}) do
    %{success: message}
  end

  def render("error.json", %{message: message}) do
    %{error: message}
  end

  def render("clock.json", %{clock: clock}) do
    %{id: clock.id,
      time: clock.time,
      status: clock.status}
  end
end

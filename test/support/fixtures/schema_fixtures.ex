defmodule Todolist.SchemaFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Todolist.Schema` context.
  """

  @doc """
  Generate a users.
  """
  def users_fixture(attrs \\ %{}) do
    {:ok, users} =
      attrs
      |> Enum.into(%{
        email: "some email",
        username: "some username"
      })
      |> Todolist.Schema.create_users()

    users
  end

  @doc """
  Generate a workingtime.
  """
  def workingtime_fixture(attrs \\ %{}) do
    {:ok, workingtime} =
      attrs
      |> Enum.into(%{
        end: ~U[2022-10-25 12:45:00Z],
        start: ~U[2022-10-25 12:45:00Z]
      })
      |> Todolist.Schema.create_workingtime()

    workingtime
  end

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~U[2022-10-25 13:17:00Z]
      })
      |> Todolist.Schema.create_clock()

    clock
  end
end

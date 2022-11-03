defmodule TodolistWeb.UsersController do
  use TodolistWeb, :controller

  alias Todolist.Schema
  alias Todolist.Schema.Users

  action_fallback TodolistWeb.FallbackController

  def index(conn, %{"username" => username, "email" => email}) do
    user = Schema.getUsernameAndEmail(username, email)
    render(conn, "show.json", users: user)
  end

  def create(conn, %{"users" => users_params}) do
    with {:ok, %Users{} = users} <- Schema.create_users(users_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.users_path(conn, :show, users))
      |> render("show.json", users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    users = Schema.get_users!(id)
    render(conn, "show.json", users: users)
  end

  def update(conn, %{"id" => id, "users" => users_params}) do
    users = Schema.get_users!(id)

    with {:ok, %Users{} = users} <- Schema.update_users(users, users_params) do
      render(conn, "show.json", users: users)
    end
  end

  def delete(conn, %{"id" => id}) do
    users = Schema.get_users!(id)

    with {:ok, %Users{}} <- Schema.delete_users(users) do
      send_resp(conn, :no_content, "")
    end
  end
end

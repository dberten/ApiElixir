defmodule TodolistWeb.UsersController do
  use TodolistWeb, :controller

  alias Todolist.Schema
  alias Todolist.Schema.Users
  alias Project.Guardian

  action_fallback TodolistWeb.FallbackController

  def index(conn, %{"username" => username, "email" => email}) do
    user = Schema.getUsernameAndEmail(username, email)
    render(conn, "show.json", users: user)
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Accounts.token_sign_in(email, password) do
      {:ok, token, _claims} ->
        conn |> render("jwt.json", jwt: token)
      _ ->
        {:error, :unauthorized}
    end
  end

  def log_out(conn) do
    Guardian.Plug.sign_out(conn)
  end

  def create(conn, %{"users" => users_params}) do
    with {:ok, %Users{} = users} <- Schema.create_users(users_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(users) do
      conn |> render("jwt.json", jwt: token)
    end
  end

  def show(conn, %{"id" => id}) do
    users = Schema.get_users!(id)
    render(conn, "show.json", users: users)
  end

  def showGuardian(conn, _params) do
    users = Guardian.Plug.current_resource(conn)
    conn |> render("users.json", users: users)
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

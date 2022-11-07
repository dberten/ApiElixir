defmodule APIWeb.UserController do
  use APIWeb, :controller

  alias API.Schema
  alias API.Schema.User

  action_fallback APIWeb.FallbackController

  def index(conn, %{"username" => username, "email" => email}) do
    try do
      user = Schema.getUserByEmailAndUsername(username, email)
      render(conn, "show.json", user: user)
    rescue
      e in Ecto.NoResultsError -> render(conn, "error.json", message: "User doesn't exists")
    end
  end

  def create(conn, %{"user" => user_params}) do
    try do
      with {:ok, %User{} = user} <- Schema.create_user(user_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.user_path(conn, :show, user))
        |> render("show.json", user: user)
      end
    rescue
      e in Ecto.ConstraintError -> render(conn, "error.json", message: "User already exists")
    end
  end

  def show(conn, %{"id" => id}) do
    try do
      user = Schema.get_user!(id)
      render(conn, "show.json", user: user)
    rescue
      e in Ecto.NoResultsError -> render(conn, "error.json", message: "User #{id} doesn't exists")
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    try do
      user = Schema.get_user!(id)
      try do
        Schema.update_user(user, user_params)
        render(conn, "show.json", user: user)
      rescue
        e in Ecto.ConstraintError -> render(conn, "error.json", message: "Please use an other email adress")
      end
    rescue
      e in Ecto.NoResultsError -> render(conn, "error.json", message: "User #{id} doesn't exists")
    end
  end

  def delete(conn, %{"id" => id}) do
    try do
      user = Schema.get_user!(id)
      with {:ok, %User{}} <- Schema.delete_user(user) do
        send_resp(conn, :no_content, "")
      end
    rescue
      e in Ecto.NoResultsError -> render(conn, "error.json", message: "User #{id} doesn't exists")
    end
  end


end

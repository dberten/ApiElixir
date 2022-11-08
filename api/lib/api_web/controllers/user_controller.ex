defmodule APIWeb.UserController do
  use APIWeb, :controller

  alias API.Schema
  alias API.Schema.User
  alias API.Guardian

  action_fallback APIWeb.FallbackController

  def index(conn, %{"username" => username, "email" => email}) do
    try do
      user = Schema.getUserByEmailAndUsername(username, email)
      render(conn, "show.json", user: user)
    rescue
      e in Ecto.NoResultsError -> render(conn, "error.json", message: "User doesn't exists")
    end
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

  def create(conn, %{"user" => user_params}) do
    try do
      with {:ok, %User{} = user} <- Schema.create_user(user_params),
      {:ok, token, _claims} <- Guardian.encode_and_sign(user)  do
        conn
        |> render("jwt.json", jwt: token)
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

  def showGuardian(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    conn |> render("user.json", user: user)
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

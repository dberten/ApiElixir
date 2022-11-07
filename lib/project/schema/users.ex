defmodule Todolist.Schema.Users do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field :username, :string
    field :email, :string
    field :password, :string
    field :role, {:array, :integer}

    timestamps()
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast(attrs, [:username, :email, :password, :role])
    |> validate_required([:username, :email, :password, :role])
    |> checkData()
  end

  def registerChangeset(users, attrs) do
    users
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> checkData()
  end

  def updateChangeset(users, attrs) do
    users
    |> cast(attrs, [:username, :email, :password, :role])
    |> checkData()
  end

  defp checkData(user) do
    user
    |> validate_format(:email, ~r/[[:alnum:]]+@[[:alnum:]]+\.[[:alnum:]]/)
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> validate_length(:password, min: 8)
    |> put_pass_hash
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes:
    %{password: password}} = changeset) do
  change(changeset, password: Bcrypt.hash_pwd_salt(password))
  end

  defp put_pass_hash(changeset), do: changeset
end

defmodule API.Schema.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:email, :username, :id]}
  schema "users" do
    field :email, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email])
    |> unique_constraint(:username, error: "User already exists")
    |> validate_required([:username, :email])
    |> validate_format(:email, ~r/[[:alnum:]]+@[[:alnum:]]+\.[[:alnum:]]/)
  end
end

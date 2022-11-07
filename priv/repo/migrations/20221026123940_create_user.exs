defmodule Todolist.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :username, :string, require: true, null: false
      add :email, :string, require: true, null: false
      add :password, :string
      add :role, {:array, :integer}

      timestamps()
    end
  end
end

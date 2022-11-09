defmodule API.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, require: true, null: false
      add :email, :string, require: true, null: false
      add :password, :string
      add :role, {:array, :integer}

      timestamps()
    end
    create unique_index(:users, [:email])
  end
end

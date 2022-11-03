defmodule Todolist.Repo.Migrations.CreateWorkingtimes do
  use Ecto.Migration

  def change do
    create table(:workingtimes) do
      add :start, :naive_datetime, require: true, null: false
      add :end, :naive_datetime, require: true, null: false
      add :user, references(:user, on_delete: :nothing, require: true, null: false)

      timestamps()
    end

    create index(:workingtimes, [:user])
  end
end

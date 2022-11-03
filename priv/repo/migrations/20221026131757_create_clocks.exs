defmodule Todolist.Repo.Migrations.CreateClocks do
  use Ecto.Migration

  def change do
    create table(:clocks) do
      add :time, :utc_datetime, require: true, null: false
      add :status, :boolean, default: false, null: false, require: true
      add :user, references(:user, on_delete: :nothing, require: true, null: false)

      timestamps()
    end

    create index(:clocks, [:user])
  end
end

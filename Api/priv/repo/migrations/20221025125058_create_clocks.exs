defmodule API.Repo.Migrations.CreateClocks do
  use Ecto.Migration

  def change do
    create table(:clocks) do
      add :time, :utc_datetime
      add :status, :boolean, default: false, null: false
      add :user, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:clocks, [:user])
  end
end

defmodule GraphqlDemo.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :type, :string, default: "regular"
      add :archived_at, :utc_datetime

      timestamps()
    end
  end
end

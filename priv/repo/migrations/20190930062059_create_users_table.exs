defmodule GraphqlDemo.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :type, :string, default: "regular"
      add :archived_at, :utc_datetime

      timestamps()
    end
  end
end

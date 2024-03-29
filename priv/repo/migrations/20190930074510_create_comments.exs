defmodule GraphqlDemo.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :content, :text
      add :archived_at, :utc_datetime
      add :post_id, references(:posts, type: :binary_id)
      add :user_id, references(:users, type: :binary_id)

      timestamps()
    end

    create index(:comments, [:post_id])
    create index(:comments, [:user_id])
  end
end

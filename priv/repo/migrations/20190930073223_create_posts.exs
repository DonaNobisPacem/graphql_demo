defmodule GraphqlDemo.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :content, :text
      add :archived_at, :utc_datetime
      add :user_id, references(:users, type: :binary_id)
      add :search_vector, :tsvector

      timestamps()
    end

    create index(:posts, [:user_id])
    create index(:posts, [:search_vector], using: "GIN")

    execute("""
      CREATE OR REPLACE FUNCTION posts_search_trigger()
      RETURNS trigger
      LANGUAGE plpgsql AS $$
        declare
          creator record;
        begin
          select * into creator from users where id = new.user_id;

          new.search_vector :=
            setweight(to_tsvector('pg_catalog.english', coalesce(new.title, '')), 'A')    ||
            setweight(to_tsvector('pg_catalog.english', coalesce(new.content, '')), 'B')  ||
            setweight(to_tsvector('pg_catalog.english', coalesce(creator.name, '')), 'B');

          return new;
        end
      $$;
    """)

    execute("""
      CREATE TRIGGER posts_search_trigger_update
      BEFORE INSERT OR UPDATE ON posts
      FOR EACH ROW EXECUTE PROCEDURE posts_search_trigger();
    """)
  end
end

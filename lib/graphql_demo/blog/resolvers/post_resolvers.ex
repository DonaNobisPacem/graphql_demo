defmodule GraphqlDemo.Blog.Resolvers.PostResolvers do
  use GraphqlDemo, :resolver
  alias GraphqlDemo.Blog.Mutations.PostMutations
  alias GraphqlDemo.Blog.Post
  alias GraphqlDemo.Blog.Queries.PostQueries

  def all_posts(params \\ %{}), do: {:ok, params |> PostQueries.query_posts() |> Repo.all()}

  def find_post(params) when is_map(params) and map_size(params) > 0 do
    params
    |> PostQueries.query_posts()
    |> Repo.all()
    |> case do
      [] -> {:ok, nil}
      [result | []] -> {:ok, result}
      _result -> {:error, "query returned more than one result"}
    end
  end

  def find_post(_params), do: {:error, "invalid query params"}

  def create_post(params), do: params |> PostMutations.create_post_changeset() |> Repo.insert()

  def update_post(%Post{} = post, params),
    do: post |> PostMutations.update_post_changeset(params) |> Repo.update()

  def delete_post(%Post{} = post),
    do: post |> PostMutations.delete_post_changeset() |> Repo.update()
end

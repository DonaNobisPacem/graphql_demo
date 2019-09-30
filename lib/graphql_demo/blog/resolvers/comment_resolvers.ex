defmodule GraphqlDemo.Blog.Resolvers.CommentResolvers do
  use GraphqlDemo, :resolver
  alias GraphqlDemo.Blog.Comment
  alias GraphqlDemo.Blog.Mutations.CommentMutations
  alias GraphqlDemo.Blog.Queries.CommentQueries

  def all_comments(params \\ %{}),
    do: {:ok, params |> CommentQueries.query_comments() |> Repo.all()}

  def find_comment(params) when is_map(params) and map_size(params) > 0 do
    params
    |> CommentQueries.query_comments()
    |> Repo.all()
    |> case do
      [] -> {:ok, nil}
      [result | []] -> {:ok, result}
      _result -> {:error, "query returned more than one result"}
    end
  end

  def find_comment(_params), do: {:error, "invalid query params"}

  def create_comment(params),
    do: params |> CommentMutations.create_comment_changeset() |> Repo.insert()

  def update_comment(%Comment{} = comment, params),
    do: comment |> CommentMutations.update_comment_changeset(params) |> Repo.update()

  def delete_comment(%Comment{} = comment),
    do: comment |> CommentMutations.delete_comment_changeset() |> Repo.update()
end

defmodule GraphqlDemo.Blog.Queries.CommentQueries do
  use GraphqlDemo, :query
  alias GraphqlDemo.Blog.Comment

  def query_comments(params \\ %{}),
    do: Comment |> where([c], is_nil(c.archived_at)) |> query_by(params)

  defp query_by(query, %{"id" => id} = params),
    do: query |> where([q], q.id == ^id) |> query_by(Map.delete(params, "id"))

  defp query_by(query, %{"user_id" => user_id} = params),
    do: query |> where([q], q.user_id == ^user_id) |> query_by(Map.delete(params, "user_id"))

  defp query_by(query, %{"post_id" => post_id} = params),
    do: query |> where([q], q.post_id == ^post_id) |> query_by(Map.delete(params, "post_id"))

  defp query_by(query, %{"preload" => preload} = params),
    do: query |> preload(^preload) |> query_by(Map.delete(params, "preload"))

  defp query_by(query, _params), do: query
end

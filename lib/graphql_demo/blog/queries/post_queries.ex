defmodule GraphqlDemo.Blog.Queries.PostQueries do
  use GraphqlDemo, :query
  alias GraphqlDemo.Blog.Post

  def query_posts(params \\ %{}),
    do: Post |> where([p], is_nil(p.archived_at)) |> query_by(params)

  defp query_by(query, %{"id" => id} = params),
    do: query |> where([q], q.id == ^id) |> query_by(Map.delete(params, "id"))

  defp query_by(query, %{"title" => title} = params),
    do: query |> where([q], q.title == ^title) |> query_by(Map.delete(params, "title"))

  defp query_by(query, %{"user_id" => user_id} = params),
    do: query |> where([q], q.user_id == ^user_id) |> query_by(Map.delete(params, "user_id"))

  defp query_by(query, %{"keyword" => keyword} = params),
    do:
      query
      |> where(fragment("search_vector @@ plainto_tsquery(?)", ^keyword))
      |> query_by(Map.delete(params, "keyword"))

  defp query_by(query, %{"preload" => preload} = params),
    do: query |> preload(^preload) |> query_by(Map.delete(params, "preload"))

  defp query_by(query, _params), do: query
end

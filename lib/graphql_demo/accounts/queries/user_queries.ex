defmodule GraphqlDemo.Accounts.Queries.UserQueries do
  use GraphqlDemo, :query
  alias GraphqlDemo.Accounts.User

  def query_users(params \\ %{}),
    do: User |> where([u], is_nil(u.archived_at)) |> query_by(params)

  defp query_by(query, %{"id" => id} = params),
    do: query |> where([q], q.id == ^id) |> query_by(Map.delete(params, "id"))

  defp query_by(query, %{"name" => name} = params),
    do: query |> where([q], q.name == ^name) |> query_by(Map.delete(params, "name"))

  defp query_by(query, %{"type" => type} = params),
    do: query |> where([q], q.type == ^type) |> query_by(Map.delete(params, "type"))

  defp query_by(query, %{"preload" => preload} = params),
    do: query |> preload(^preload) |> query_by(Map.delete(params, "preload"))

  defp query_by(query, _params), do: query
end

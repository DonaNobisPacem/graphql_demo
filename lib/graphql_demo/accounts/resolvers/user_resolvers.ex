defmodule GraphqlDemo.Accounts.Resolvers.UserResolvers do
  use GraphqlDemo, :resolver
  alias GraphqlDemo.Accounts.Mutations.UserMutations
  alias GraphqlDemo.Accounts.Queries.UserQueries
  alias GraphqlDemo.Accounts.User

  def all_users(params \\ %{}), do: {:ok, params |> UserQueries.query_users() |> Repo.all()}

  def find_user(params) when is_map(params) and map_size(params) > 0 do
    params
    |> UserQueries.query_users()
    |> Repo.all()
    |> case do
      [] -> {:ok, nil}
      [result | nil] -> {:ok, result}
      _result -> {:error, "query returned more than one result"}
    end
  end

  def create_user(params), do: params |> UserMutations.create_user_changeset() |> Repo.insert()

  def update_user(%User{} = user, params),
    do: user |> UserMutations.update_user_changeset(params) |> Repo.update()

  def delete_user(%User{} = user),
    do: user |> UserMutations.delete_user_changeset() |> Repo.update()
end

defmodule GraphqlDemoWeb.Graphql.Accounts.Queries.UserQueries do
  use GraphqlDemoWeb.Graphql, :query
  alias GraphqlDemoWeb.Graphql.Accounts.Resolvers.UserResolvers

  object :user_queries do
    @desc "List all users with given params"
    field :users, list_of(:user) do
      arg(:email, :string)
      arg(:name, :string)
      resolve(&UserResolvers.all/2)
    end

    @desc "Find a user with given params"
    field :user, type: :user do
      arg(:id, :id)
      arg(:email, :string)
      arg(:name, :string)
      resolve(&UserResolvers.find/2)
    end

    @desc "Returns current_user"
    field :account, type: :user do
      resolve(&fetch_current_user/3)
    end
  end

  defp fetch_current_user(_, _, %{context: %{current_user: current_user}}),
    do: {:ok, current_user}

  defp fetch_current_user(_, _, _context), do: {:error, "unauthorized"}
end

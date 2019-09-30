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
      resolve(fn _, _, %{context: %{current_user: current_user}} ->
        {:ok, current_user}
      end)
    end
  end
end

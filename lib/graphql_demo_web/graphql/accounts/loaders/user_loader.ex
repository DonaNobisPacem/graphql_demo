defmodule GraphqlDemoWeb.Graphql.Accounts.Loaders.UserLoader do
  use GraphqlDemoWeb.Graphql, :loader
  alias GraphqlDemo.Accounts
  alias GraphqlDemo.Accounts.User

  def data do
    DEcto.new(Repo, query: &query/2)
  end

  def query(User, params), do: Accounts.query_users(params)
  def query(queryable, _params), do: queryable
end

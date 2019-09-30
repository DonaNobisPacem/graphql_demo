defmodule GraphqlDemo.Accounts do
  alias GraphqlDemo.Accounts.Mutations.UserMutations
  alias GraphqlDemo.Accounts.Queries.UserQueries
  alias GraphqlDemo.Accounts.Resolvers.UserResolvers

  defdelegate query_users(params \\ %{}), to: UserQueries
  defdelegate build_user_changeset(user, params \\ %{}), to: UserMutations
  defdelegate all_users(params \\ %{}), to: UserResolvers
  defdelegate find_user(params), to: UserResolvers
  defdelegate create_user(params), to: UserResolvers
  defdelegate update_user(user, params), to: UserResolvers
  defdelegate delete_user(user), to: UserResolvers
end

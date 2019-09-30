defmodule GraphqlDemoWeb.Graphql.Schema do
  use GraphqlDemoWeb.Graphql, :schema
  alias GraphqlDemoWeb.Graphql.Accounts.Mutations.UserMutations
  alias GraphqlDemoWeb.Graphql.Accounts.Queries.UserQueries
  alias GraphqlDemoWeb.Graphql.Accounts.Types.UserType

  # TYPES
  import_types(Absinthe.Plug.Types)
  import_types(Absinthe.Type.Custom)

  import_types(UserType)

  # QUERIES
  import_types(UserQueries)

  # MUTATIONS
  import_types(UserMutations)

  # SUBSCRIPTIONS
  # import_types(CommentSubscriptions)

  query do
    import_fields(:user_queries)
  end

  mutation do
    import_fields(:user_mutations)
  end

  subscription do
  end
end

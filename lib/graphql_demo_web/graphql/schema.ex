defmodule GraphqlDemoWeb.Graphql.Schema do
  use GraphqlDemoWeb.Graphql, :schema
  alias GraphqlDemoWeb.Graphql.Accounts.Mutations.UserMutations
  alias GraphqlDemoWeb.Graphql.Accounts.Queries.UserQueries
  alias GraphqlDemoWeb.Graphql.Accounts.Types.UserType
  alias GraphqlDemoWeb.Graphql.Accounts.Loaders.UserLoader

  alias GraphqlDemoWeb.Graphql.Blog.Mutations.PostMutations
  alias GraphqlDemoWeb.Graphql.Blog.Queries.PostQueries
  alias GraphqlDemoWeb.Graphql.Blog.Types.PostType
  alias GraphqlDemoWeb.Graphql.Blog.Loaders.PostLoader

  alias GraphqlDemoWeb.Graphql.Blog.Mutations.CommentMutations
  alias GraphqlDemoWeb.Graphql.Blog.Queries.CommentQueries
  alias GraphqlDemoWeb.Graphql.Blog.Types.CommentType
  alias GraphqlDemoWeb.Graphql.Blog.Loaders.CommentLoader

  # TYPES
  import_types(Absinthe.Plug.Types)
  import_types(Absinthe.Type.Custom)

  import_types(UserType)
  import_types(PostType)
  import_types(CommentType)

  # QUERIES
  import_types(UserQueries)
  import_types(PostQueries)
  import_types(CommentQueries)

  # MUTATIONS
  import_types(UserMutations)
  import_types(PostMutations)
  import_types(CommentMutations)

  # SUBSCRIPTIONS
  # import_types(CommentSubscriptions)

  query do
    import_fields(:user_queries)
    import_fields(:post_queries)
    import_fields(:comment_queries)
  end

  mutation do
    import_fields(:user_mutations)
    import_fields(:post_mutations)
    import_fields(:comment_mutations)
  end

  subscription do
  end

  def context(ctx) do
    Map.put(ctx, :loader, dataloader())
  end

  def dataloader do
    Dataloader.new()
    |> Dataloader.add_source(UserLoader, UserLoader.data())
    |> Dataloader.add_source(PostLoader, PostLoader.data())
    |> Dataloader.add_source(CommentLoader, CommentLoader.data())
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end

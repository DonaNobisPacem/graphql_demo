defmodule GraphqlDemoWeb.Graphql.Blog.Queries.PostQueries do
  use GraphqlDemoWeb.Graphql, :query
  alias GraphqlDemoWeb.Graphql.Blog.Resolvers.PostResolvers

  object :post_queries do
    @desc "List all posts with given params"
    field :posts, list_of(:post) do
      arg(:title, :string)
      arg(:keyword, :string)
      arg(:user_id, :id)
      resolve(&PostResolvers.all/2)
    end

    @desc "Find a post with given params"
    field :post, type: :post do
      arg(:id, :id)
      arg(:title, :string)
      arg(:keyword, :string)
      arg(:user_id, :id)
      resolve(&PostResolvers.find/2)
    end
  end
end

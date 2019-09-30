defmodule GraphqlDemoWeb.Graphql.Blog.Queries.CommentQueries do
  use GraphqlDemoWeb.Graphql, :query
  alias GraphqlDemoWeb.Graphql.Blog.Resolvers.CommentResolvers

  object :comment_queries do
    @desc "List all comments with given params"
    field :comments, list_of(:comment) do
      arg(:user_id, :id)
      arg(:post_id, :id)
      resolve(&CommentResolvers.all/2)
    end

    @desc "Find a pcommentt with given params"
    field :comment, type: :comment do
      arg(:id, :id)
      arg(:user_id, :id)
      arg(:post_id, :id)
      resolve(&CommentResolvers.find/2)
    end
  end
end

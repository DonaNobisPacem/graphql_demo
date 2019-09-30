defmodule GraphqlDemoWeb.Graphql.Blog.Mutations.CommentMutations do
  use GraphqlDemoWeb.Graphql, :type
  alias GraphqlDemoWeb.Graphql.Blog.Resolvers.CommentResolvers

  object :comment_mutations do
    @desc "Create a comment with given params"
    field :create_comment, type: :comment do
      arg(:content, non_null(:string))
      arg(:post_id, non_null(:id))

      resolve(&CommentResolvers.create_comment/2)
    end

    @desc "Update a comment with given params"
    field :update_comment, type: :comment do
      arg(:id, non_null(:id))
      arg(:content, :string)
      arg(:post_id, non_null(:id))

      resolve(&CommentResolvers.update_comment/2)
    end

    @desc "Delete a comment with given params"
    field :delete_comment, type: :comment do
      arg(:id, non_null(:id))

      resolve(&CommentResolvers.delete_comment/2)
    end
  end
end

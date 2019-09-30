defmodule GraphqlDemoWeb.Graphql.Blog.Mutations.PostMutations do
  use GraphqlDemoWeb.Graphql, :type
  alias GraphqlDemoWeb.Graphql.Blog.Resolvers.PostResolvers

  object :post_mutations do
    @desc "Create a post with given params"
    field :create_post, type: :post do
      arg(:title, non_null(:string))
      arg(:content, non_null(:string))

      resolve(&PostResolvers.create_post/2)
    end

    @desc "Update a post with given params"
    field :update_post, type: :post do
      arg(:id, non_null(:id))
      arg(:title, :string)
      arg(:content, :string)

      resolve(&PostResolvers.update_post/2)
    end

    @desc "Delete a post with given params"
    field :delete_post, type: :post do
      arg(:id, non_null(:id))

      resolve(&PostResolvers.delete_post/2)
    end
  end
end

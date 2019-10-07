defmodule GraphqlDemoWeb.Graphql.Blog.Mutations.PostMutations do
  use GraphqlDemoWeb.Graphql, :type
  alias GraphqlDemoWeb.Graphql.Blog.Resolvers.PostResolvers

  object :post_mutations do
    @desc "Create a post with given params"
    field :create_post, type: :post do
      arg(:title, non_null(:string))
      arg(:content, non_null(:string))

      resolve(fn args, context -> authenticator(args, context, &PostResolvers.create_post/2) end)
    end

    @desc "Update a post with given params"
    field :update_post, type: :post do
      arg(:id, non_null(:id))
      arg(:title, :string)
      arg(:content, :string)

      resolve(fn args, context -> authenticator(args, context, &PostResolvers.update_post/2) end)
    end

    @desc "Delete a post with given params"
    field :delete_post, type: :post do
      arg(:id, non_null(:id))

      resolve(fn args, context -> authenticator(args, context, &PostResolvers.delete_post/2) end)
    end
  end
end

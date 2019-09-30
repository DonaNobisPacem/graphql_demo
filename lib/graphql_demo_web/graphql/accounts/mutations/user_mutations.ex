defmodule GraphqlDemoWeb.Graphql.Accounts.Mutations.UserMutations do
  use GraphqlDemoWeb.Graphql, :type
  alias GraphqlDemoWeb.Graphql.Accounts.Resolvers.UserResolvers

  object :user_mutations do
    @desc "Create a user with given params"
    field :create_user, type: :user do
      arg(:name, non_null(:string))
      arg(:email, non_null(:string))
      arg(:type, :string)

      resolve(&UserResolvers.create_user/2)
    end

    @desc "Update a user with given params"
    field :update_user, type: :user do
      arg(:id, non_null(:id))
      arg(:name, :string)
      arg(:email, :string)
      arg(:type, :string)

      resolve(&UserResolvers.update_user/2)
    end

    @desc "Delete a user with given params"
    field :delete_user, type: :user do
      arg(:id, non_null(:id))

      resolve(&UserResolvers.delete_user/2)
    end
  end
end

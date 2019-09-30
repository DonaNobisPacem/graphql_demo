defmodule GraphqlDemoWeb.Graphql.Blog.Types.CommentType do
  use GraphqlDemoWeb.Graphql, :type
  alias GraphqlDemoWeb.Graphql.Accounts.Loaders.UserLoader
  alias GraphqlDemoWeb.Graphql.Blog.Loaders.PostLoader

  object :comment do
    field :id, :id
    field :content, :string
    field :archived_at, :datetime

    field :post, :post, resolve: dataloader(PostLoader)
    field :user, :user, resolve: dataloader(UserLoader)

    field :inserted_at, :datetime
    field :updated_at, :datetime
  end
end

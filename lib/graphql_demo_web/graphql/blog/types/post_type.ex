defmodule GraphqlDemoWeb.Graphql.Blog.Types.PostType do
  use GraphqlDemoWeb.Graphql, :type
  alias GraphqlDemoWeb.Graphql.Accounts.Loaders.UserLoader
  alias GraphqlDemoWeb.Graphql.Blog.Loaders.CommentLoader

  object :post do
    field :id, :id
    field :title, :string
    field :content, :string
    field :archived_at, :datetime

    field :user, :user, resolve: dataloader(UserLoader)
    field :comments, list_of(:comment), resolve: dataloader(CommentLoader)

    field :inserted_at, :datetime
    field :updated_at, :datetime
  end
end

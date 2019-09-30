defmodule GraphqlDemoWeb.Graphql.Accounts.Types.UserType do
  use GraphqlDemoWeb.Graphql, :type
  alias GraphqlDemoWeb.Graphql.Blog.Loaders.PostLoader
  alias GraphqlDemoWeb.Graphql.Blog.Loaders.CommentLoader

  object :user do
    field :id, :id
    field :name, :string
    field :email, :string
    field :archived_at, :datetime

    field :posts, list_of(:post), resolve: dataloader(PostLoader)
    field :comments, list_of(:comment), resolve: dataloader(CommentLoader)

    field :inserted_at, :datetime
    field :updated_at, :datetime
  end
end

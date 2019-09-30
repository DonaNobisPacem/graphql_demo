defmodule GraphqlDemo.Factories.BlogFactories do
  @moduledoc false
  alias GraphqlDemo.Blog.Post
  alias GraphqlDemo.Blog.Comment

  def get_resource(resource, params \\ %{})

  def get_resource(:post, params) do
    defaults = %Post{
      title: "Post Title",
      content: "Post Content"
    }

    Map.merge(defaults, params)
  end

  def get_resource(:comment, params) do
    defaults = %Comment{
      content: "Comment Content"
    }

    Map.merge(defaults, params)
  end
end

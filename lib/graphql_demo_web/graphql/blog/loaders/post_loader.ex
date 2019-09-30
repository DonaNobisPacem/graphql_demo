defmodule GraphqlDemoWeb.Graphql.Blog.Loaders.PostLoader do
  use GraphqlDemoWeb.Graphql, :loader
  alias GraphqlDemo.Blog
  alias GraphqlDemo.Blog.Post

  def data do
    DEcto.new(Repo, query: &query/2)
  end

  def query(Post, params), do: Blog.query_posts(params)
  def query(queryable, _params), do: queryable
end

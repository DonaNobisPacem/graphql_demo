defmodule GraphqlDemoWeb.Graphql.Blog.Loaders.CommentLoader do
  use GraphqlDemoWeb.Graphql, :loader
  alias GraphqlDemo.Blog
  alias GraphqlDemo.Blog.Comment

  def data do
    DEcto.new(Repo, query: &query/2)
  end

  def query(Comment, params), do: Blog.query_comments(params)
  def query(queryable, _params), do: queryable
end

defmodule GraphqlDemoWeb.Graphql.Blog.Resolvers.CommentResolvers do
  use GraphqlDemoWeb.Graphql, :resolver
  alias GraphqlDemo.Blog

  def all(args, _info), do: args |> stringify_keys |> Blog.all_comments()
  def find(args, _info), do: args |> stringify_keys |> Blog.find_comment()

  def create_comment(args, %{context: %{current_user: user}}),
    do:
      args
      |> stringify_keys
      |> Map.put("user_id", user.id)
      |> Blog.create_comment()
      |> format_results

  def create_comment(_args, _info), do: {:error, "unauthenticated"}

  def update_comment(args, _info) do
    case Blog.find_comment(%{"id" => args.id}) do
      {:ok, comment} ->
        params = args |> Map.delete(:id) |> stringify_keys

        comment
        |> Blog.update_comment(params)
        |> format_results

      output ->
        output
    end
  end

  def delete_comment(args, _info) do
    case Blog.find_comment(%{"id" => args.id}) do
      {:ok, comment} ->
        comment
        |> Blog.delete_comment()
        |> format_results

      output ->
        output
    end
  end
end

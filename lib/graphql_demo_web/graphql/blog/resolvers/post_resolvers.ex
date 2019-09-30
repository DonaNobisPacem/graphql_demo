defmodule GraphqlDemoWeb.Graphql.Blog.Resolvers.PostResolvers do
  use GraphqlDemoWeb.Graphql, :resolver
  alias GraphqlDemo.Blog

  def all(args, _info), do: args |> stringify_keys |> Blog.all_posts()
  def find(args, _info), do: args |> stringify_keys |> Blog.find_post()

  def create_post(args, %{context: %{current_user: user}}),
    do:
      args
      |> stringify_keys
      |> Map.put("user_id", user.id)
      |> Blog.create_post()
      |> format_results

  def create_post(_args, _info), do: {:error, "unauthenticated"}

  def update_post(args, _info) do
    case Blog.find_post(%{"id" => args.id}) do
      {:ok, post} ->
        params = args |> Map.delete(:id) |> stringify_keys

        post
        |> Blog.update_post(params)
        |> format_results

      output ->
        output
    end
  end

  def delete_post(args, _info) do
    case Blog.find_post(%{"id" => args.id}) do
      {:ok, post} ->
        post
        |> Blog.delete_post()
        |> format_results

      output ->
        output
    end
  end
end

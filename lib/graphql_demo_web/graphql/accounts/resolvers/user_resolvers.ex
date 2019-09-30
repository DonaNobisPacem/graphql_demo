defmodule GraphqlDemoWeb.Graphql.Accounts.Resolvers.UserResolvers do
  use GraphqlDemoWeb.Graphql, :resolver
  alias GraphqlDemo.Accounts

  def all(args, _info), do: args |> stringify_keys |> Accounts.all_users()
  def find(args, _info), do: args |> stringify_keys |> Accounts.find_user()

  def create_user(args, _info),
    do: args |> stringify_keys |> Accounts.create_user() |> format_results

  def update_user(args, _info) do
    case Accounts.find_user(%{"id" => args.id}) do
      {:ok, user} ->
        params = args |> Map.delete(:id) |> stringify_keys

        user
        |> Accounts.update_user(params)
        |> format_results

      output ->
        output
    end
  end

  def delete_user(args, _info) do
    case Accounts.find_user(%{"id" => args.id}) do
      {:ok, user} ->
        user
        |> Accounts.delete_user()
        |> format_results

      output ->
        output
    end
  end
end

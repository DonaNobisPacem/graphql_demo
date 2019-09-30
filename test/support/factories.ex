defmodule GraphqlDemo.Factories do
  @moduledoc """
  Collection of factories to be used for tests
  """
  alias GraphqlDemo.Factories.AccountsFactories
  alias GraphqlDemo.Factories.BlogFactories
  alias GraphqlDemo.Repo

  def build(resource, params \\ %{}), do: get_resource(resource, params)

  def insert(resource, params \\ %{}) do
    resource
    |> get_resource(params)
    |> Repo.insert!()
  end

  def get_resource(resource, params) when resource in [:user],
    do: AccountsFactories.get_resource(resource, params)

  def get_resource(resource, params) when resource in [:post, :comment],
    do: BlogFactories.get_resource(resource, params)
end

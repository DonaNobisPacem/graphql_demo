defmodule GraphqlDemo.Factories.AccountsFactories do
  @moduledoc false
  alias GraphqlDemo.Accounts.User

  def get_resource(resource, params \\ %{})

  def get_resource(:user, params) do
    defaults = %User{
      name: "User Name"
    }

    Map.merge(defaults, params)
  end
end

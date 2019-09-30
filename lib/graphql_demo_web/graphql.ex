defmodule GraphqlDemoWeb.Graphql do
  alias Absinthe.Schema.Notation

  def type do
    quote do
      use Notation
      import Absinthe.Resolution.Helpers, only: [dataloader: 1]
    end
  end

  def query do
    quote do
      use Notation
    end
  end

  def schema do
    quote do
      use Absinthe.Schema
    end
  end

  def resolver do
    quote do
      import GraphqlDemoWeb.Helpers.GraphqlHelpers
    end
  end

  def loader do
    quote do
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end

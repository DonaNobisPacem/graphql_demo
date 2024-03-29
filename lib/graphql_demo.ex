defmodule GraphqlDemo do
  @moduledoc """
  GraphqlDemo keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias Ecto.Changeset
  alias Ecto.Multi
  alias Ecto.Query
  alias Ecto.Schema

  def schema do
    quote do
      use Schema
      import Changeset

      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
    end
  end

  def query do
    quote do
      import Query
    end
  end

  def mutation do
    quote do
      alias Multi
      import Changeset
    end
  end

  def resolver do
    quote do
      alias GraphqlDemo.Repo
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end

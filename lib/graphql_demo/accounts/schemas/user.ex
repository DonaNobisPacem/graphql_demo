defmodule GraphqlDemo.Accounts.User do
  use GraphqlDemo, :schema

  schema "users" do
    field :name, :string
    field :email, :string
    field :type, :string, default: "regular"
    field :archived_at, :utc_datetime

    timestamps()
  end

  @required_attrs [:name, :email, :type]
  @optional_attrs []
  @types ["regular", "admin"]

  @doc false
  def changeset(%__MODULE__{} = struct, params \\ %{}) do
    struct
    |> cast(params, @required_attrs ++ @optional_attrs)
    |> validate_required(@required_attrs)
    |> validate_inclusion(:type, @types)
    |> unique_constraint(:email)
  end
end

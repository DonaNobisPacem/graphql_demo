defmodule GraphqlDemo.Blog.Post do
  use GraphqlDemo, :schema

  schema "posts" do
    field :title, :string
    field :content, :string
    field :archived_at, :utc_datetime

    belongs_to :user, GraphqlDemo.Accounts.User

    timestamps()
  end

  @required_attrs [:title, :user_id]
  @optional_attrs [:content]

  @doc false
  def changeset(%__MODULE__{} = struct, params \\ %{}) do
    struct
    |> cast(params, @required_attrs ++ @optional_attrs)
    |> validate_required(@required_attrs)
    |> foreign_key_constraint(:user_id)
  end
end

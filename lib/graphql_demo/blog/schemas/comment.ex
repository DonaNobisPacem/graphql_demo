defmodule GraphqlDemo.Blog.Comment do
  use GraphqlDemo, :schema

  schema "comments" do
    field :content, :string
    field :archived_at, :utc_datetime

    belongs_to :user, GraphqlDemo.Accounts.User
    belongs_to :post, GraphqlDemo.Blog.Post

    timestamps()
  end

  @required_attrs [:content, :post_id, :user_id]
  @optional_attrs []

  @doc false
  def changeset(%__MODULE__{} = struct, params \\ %{}) do
    struct
    |> cast(params, @required_attrs ++ @optional_attrs)
    |> validate_required(@required_attrs)
    |> foreign_key_constraint(:post_id)
    |> foreign_key_constraint(:user_id)
  end
end

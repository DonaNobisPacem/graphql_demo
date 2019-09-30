defmodule GraphqlDemo.Accounts.Mutations.UserMutations do
  use GraphqlDemo, :mutation
  alias GraphqlDemo.Accounts.User

  def build_user_changeset(%User{} = user, params \\ %{}), do: User.changeset(user, params)

  def create_user_changeset(params), do: build_user_changeset(%User{}, params)

  def update_user_changeset(%User{} = user, params), do: build_user_changeset(user, params)

  def delete_user_changeset(%User{} = user),
    do:
      user
      |> build_user_changeset
      |> put_change(:archived_at, DateTime.truncate(DateTime.utc_now(), :second))
end

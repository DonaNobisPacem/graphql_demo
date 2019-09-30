defmodule GraphqlDemo.Blog.Mutations.CommentMutations do
  use GraphqlDemo, :mutation
  alias GraphqlDemo.Blog.Comment

  def build_comment_changeset(%Comment{} = comment, params \\ %{}),
    do: Comment.changeset(comment, params)

  def create_comment_changeset(params), do: build_comment_changeset(%Comment{}, params)

  def update_comment_changeset(%Comment{} = comment, params),
    do: build_comment_changeset(comment, params)

  def delete_comment_changeset(%Comment{} = comment),
    do:
      comment
      |> build_comment_changeset
      |> put_change(:archived_at, DateTime.truncate(DateTime.utc_now(), :second))
end

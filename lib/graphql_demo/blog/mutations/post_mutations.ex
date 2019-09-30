defmodule GraphqlDemo.Blog.Mutations.PostMutations do
  use GraphqlDemo, :mutation
  alias GraphqlDemo.Blog.Post

  def build_post_changeset(%Post{} = post, params \\ %{}), do: Post.changeset(post, params)

  def create_post_changeset(params), do: build_post_changeset(%Post{}, params)

  def update_post_changeset(%Post{} = post, params), do: build_post_changeset(post, params)

  def delete_post_changeset(%Post{} = post),
    do:
      post
      |> build_post_changeset
      |> put_change(:archived_at, DateTime.truncate(DateTime.utc_now(), :second))
end

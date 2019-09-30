defmodule GraphqlDemo.Blog do
  alias GraphqlDemo.Blog.Mutations.CommentMutations
  alias GraphqlDemo.Blog.Mutations.PostMutations
  alias GraphqlDemo.Blog.Queries.CommentQueries
  alias GraphqlDemo.Blog.Queries.PostQueries
  alias GraphqlDemo.Blog.Resolvers.CommentResolvers
  alias GraphqlDemo.Blog.Resolvers.PostResolvers

  defdelegate query_posts(params \\ %{}), to: PostQueries
  defdelegate build_post_changeset(post, params \\ %{}), to: PostMutations
  defdelegate all_posts(params \\ %{}), to: PostResolvers
  defdelegate find_post(params), to: PostResolvers
  defdelegate create_post(params), to: PostResolvers
  defdelegate update_post(post, params), to: PostResolvers
  defdelegate delete_post(post), to: PostResolvers

  defdelegate query_comments(params \\ %{}), to: CommentQueries
  defdelegate build_comment_changeset(comment, params \\ %{}), to: CommentMutations
  defdelegate all_comments(params \\ %{}), to: CommentResolvers
  defdelegate find_comment(params), to: CommentResolvers
  defdelegate create_comment(params), to: CommentResolvers
  defdelegate update_comment(comment, params), to: CommentResolvers
  defdelegate delete_comment(comment), to: CommentResolvers
end

defmodule GraphqlDemoWeb.Graphql.Blog.Subscriptions.CommentSubscriptions do
  use GraphqlDemoWeb.Graphql, :type

  object :comment_subscriptions do
    @desc "Subscription for when a comment is created for a nsw contract"
    field :comment_created, type: :comment do
      arg(:post_id, non_null(:id))

      config(fn args, _ ->
        {:ok, topic: args.post_id}
      end)

      trigger(:create_comment,
        topic: fn comment ->
          comment.post_id
        end
      )
    end
  end
end

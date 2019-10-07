defmodule GraphqlDemoWeb.Graphql.Blog.Subscriptions.PostSubscriptions do
  use GraphqlDemoWeb.Graphql, :type

  @post_created_topic "post_created"

  object :post_subscriptions do
    @desc "Subscription for when a post is created for a nsw contract"
    field :post_created, type: :post do
      config(fn _args, _ ->
        {:ok, topic: @post_created_topic, context_id: "global"}
      end)

      trigger(:create_post,
        topic: fn _post ->
          @post_created_topic
        end
      )
    end
  end
end

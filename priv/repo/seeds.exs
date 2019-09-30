# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     GraphqlDemo.Repo.insert!(%GraphqlDemo.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule GraphqlDemo.Seeds do
  Faker.start()

  alias GraphqlDemo.Accounts
  alias GraphqlDemo.Blog

  def run do
    {:ok, user} =
      Accounts.create_user(%{
        "email" => "admin@demo.com",
        "name" => "Admin User",
        "type" => "admin"
      })

    users = create_users() ++ [user]
    posts = create_posts(users)
    _comments = create_comments(users, posts)
  end

  defp create_users do
    for index <- 1..5 do
      {:ok, user} =
        Accounts.create_user(%{
          "email" => "user+#{index}@demo.com",
          "name" => Faker.Name.name()
        })

      user
    end
  end

  defp create_posts(users) do
    for _index <- 1..20 do
      user = Enum.random(users)

      {:ok, post} =
        Blog.create_post(%{
          "title" => Faker.Food.dish(),
          "content" => Faker.Lorem.paragraph(),
          "user_id" => user.id
        })

      if Enum.random([true, false]) do
        Blog.delete_post(post)
      end

      post
    end
  end

  defp create_comments(users, posts) do
    for post <- posts do
      for _index <- 1..10 do
        user = Enum.random(users)

        {:ok, comment} =
          Blog.create_comment(%{
            "content" => Faker.StarWars.quote(),
            "user_id" => user.id,
            "post_id" => post.id
          })

        if Enum.random([true, false]) do
          Blog.delete_comment(comment)
        end

        comment
      end
    end
  end
end

GraphqlDemo.Seeds.run()

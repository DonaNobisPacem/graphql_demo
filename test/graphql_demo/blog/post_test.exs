defmodule GraphqlDemo.Blog.PostTest do
  use GraphqlDemo.DataCase
  alias GraphqlDemo.Blog

  setup do
    user = insert(:user)
    post = insert(:post, %{user_id: user.id})
    insert(:post, %{user_id: user.id, title: "another post"})

    {:ok, user: user, post: post}
  end

  describe "all_posts/2" do
    test "returns a list of all posts when no arguments are provided" do
      assert {:ok, posts} = Blog.all_posts()
      assert is_list(posts)
      assert length(posts) == 2
    end

    test "returns a list of posts with matching values when filter arguments are provided",
         %{
           post: post
         } do
      assert {:ok, posts} = Blog.all_posts(%{"title" => post.title})
      assert is_list(posts)
      assert length(posts) == 1
    end

    test "returns an empty list of when no posts match the post criteria" do
      assert {:ok, posts} = Blog.all_posts(%{"title" => "idonotexist"})
      assert is_list(posts)
      assert Enum.empty?(posts)
    end
  end

  describe "find_post/2" do
    test "returns an {:ok, post} resource with matching values with the filter arguments provided",
         %{
           post: post
         } do
      assert {:ok, post} = Blog.find_post(%{"title" => post.title})
    end

    test "returns an {:ok, nil} when no matching post is found" do
      assert {:ok, nil} = Blog.find_post(%{"title" => "idonotexist"})
    end

    test "returns an {:error, message} when multiple posts are found" do
      assert {:error, _message} = Blog.find_post(%{"type" => "regular"})
    end

    test "returns an {:error, message} when search params are empty" do
      assert {:error, _message} = Blog.find_post(%{})
    end
  end

  describe "create_post/1" do
    @valid_attrs %{"title" => "newpost@post.com"}
    @invalid_attrs %{}

    test "creates a post resource when params are valid", %{user: user} do
      assert {:ok, post} = @valid_attrs |> Map.put("user_id", user.id) |> Blog.create_post()
      assert post.title == @valid_attrs["title"]
      assert post.user_id == user.id
    end

    test "returns an error when params are invalid" do
      assert {:error, _changeset} = Blog.create_post(@invalid_attrs)
    end
  end

  describe "update_post/2" do
    @valid_attrs %{
      "title" => "updatepost@title.com"
    }
    @invalid_attrs %{
      "title" => nil
    }

    test "updates a post resource when params are valid", %{
      post: post
    } do
      assert {:ok, post} = Blog.update_post(post, @valid_attrs)
      assert post.title == @valid_attrs["title"]
    end

    test "returns an error when params are invalid", %{post: post} do
      assert {:error, _changeset} = Blog.update_post(post, @invalid_attrs)
    end
  end

  describe "delete_post/1" do
    test "deletes a post resource", %{post: post} do
      assert {:ok, post} = Blog.delete_post(post)
      assert {:ok, nil} = Blog.find_post(%{"id" => post.id})
      refute is_nil(post.archived_at)
    end
  end
end

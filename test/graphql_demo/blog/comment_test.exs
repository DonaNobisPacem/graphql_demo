defmodule GraphqlDemo.Blog.CommentTest do
  use GraphqlDemo.DataCase
  alias GraphqlDemo.Blog

  setup do
    user = insert(:user)
    post = insert(:post, %{user_id: user.id})
    comment = insert(:comment, %{user_id: user.id, post_id: post.id})
    insert(:comment, %{user_id: user.id, post_id: post.id, content: "some other comment"})

    {:ok, user: user, post: post, comment: comment}
  end

  describe "all_comments/2" do
    test "returns a list of all comments when no arguments are provided" do
      assert {:ok, comments} = Blog.all_comments()
      assert is_list(comments)
      assert length(comments) == 2
    end

    test "returns a list of comments with matching values when filter arguments are provided",
         %{
           comment: comment
         } do
      assert {:ok, comments} = Blog.all_comments(%{"content" => comment.content})
      assert is_list(comments)
      assert length(comments) == 1
    end

    test "returns an empty list of when no comments match the comment criteria" do
      assert {:ok, comments} = Blog.all_comments(%{"content" => "idonotexist"})
      assert is_list(comments)
      assert Enum.empty?(comments)
    end
  end

  describe "find_comment/2" do
    test "returns an {:ok, comment} resource with matching values with the filter arguments provided",
         %{
           comment: comment
         } do
      assert {:ok, comment} = Blog.find_comment(%{"content" => comment.content})
    end

    test "returns an {:ok, nil} when no matching comment is found" do
      assert {:ok, nil} = Blog.find_comment(%{"content" => "idonotexist"})
    end

    test "returns an {:error, message} when multiple comments are found" do
      assert {:error, _message} = Blog.find_comment(%{"type" => "regular"})
    end

    test "returns an {:error, message} when search params are empty" do
      assert {:error, _message} = Blog.find_comment(%{})
    end
  end

  describe "create_comment/1" do
    @valid_attrs %{"content" => "newcomment@comment.com"}
    @invalid_attrs %{}

    test "creates a comment resource when params are valid", %{user: user, post: post} do
      assert {:ok, comment} =
               @valid_attrs
               |> Map.put("user_id", user.id)
               |> Map.put("post_id", post.id)
               |> Blog.create_comment()

      assert comment.content == @valid_attrs["content"]
      assert comment.post_id == post.id
      assert comment.user_id == user.id
    end

    test "returns an error when params are invalid" do
      assert {:error, _changeset} = Blog.create_comment(@invalid_attrs)
    end
  end

  describe "update_comment/2" do
    @valid_attrs %{
      "content" => "updatecomment@content.com"
    }
    @invalid_attrs %{
      "content" => nil
    }

    test "updates a comment resource when params are valid", %{
      comment: comment
    } do
      assert {:ok, comment} = Blog.update_comment(comment, @valid_attrs)
      assert comment.content == @valid_attrs["content"]
    end

    test "returns an error when params are invalid", %{comment: comment} do
      assert {:error, _changeset} = Blog.update_comment(comment, @invalid_attrs)
    end
  end

  describe "delete_comment/1" do
    test "deletes a comment resource", %{comment: comment} do
      assert {:ok, comment} = Blog.delete_comment(comment)
      assert {:ok, nil} = Blog.find_comment(%{"id" => comment.id})
      refute is_nil(comment.archived_at)
    end
  end
end

defmodule GraphqlDemo.Accounts.UserTest do
  use GraphqlDemo.DataCase
  alias GraphqlDemo.Accounts

  setup do
    user = insert(:user)
    insert(:user, %{name: "other user"})

    {:ok, user: user}
  end

  describe "all_users/2" do
    test "returns a list of all users when no arguments are provided" do
      assert {:ok, users} = Accounts.all_users()
      assert is_list(users)
      assert length(users) == 2
    end

    test "returns a list of users with matching values when filter arguments are provided",
         %{
           user: user
         } do
      assert {:ok, users} = Accounts.all_users(%{"name" => user.name})
      assert is_list(users)
      assert length(users) == 1
    end

    test "returns an empty list of when no users match the user criteria" do
      assert {:ok, users} = Accounts.all_users(%{"name" => "idonotexist"})
      assert is_list(users)
      assert Enum.empty?(users)
    end
  end

  describe "find_user/2" do
    test "returns an {:ok, user} resource with matching values with the filter arguments provided",
         %{
           user: user
         } do
      assert {:ok, user} = Accounts.find_user(%{"name" => user.name})
    end

    test "returns an {:ok, nil} when no matching user is found" do
      assert {:ok, nil} = Accounts.find_user(%{"name" => "idonotexist"})
    end

    test "returns an {:error, message} when multiple users are found" do
      assert {:error, _message} = Accounts.find_user(%{"type" => "regular"})
    end

    test "returns an {:error, message} when search params are empty" do
      assert {:error, _message} = Accounts.find_user(%{})
    end
  end

  describe "create_user/1" do
    @valid_attrs %{"name" => "newuser@user.com"}
    @invalid_attrs %{}

    test "creates a user resource when params are valid" do
      assert {:ok, user} = Accounts.create_user(@valid_attrs)
      assert user.name == @valid_attrs["name"]
    end

    test "returns an error when params are invalid" do
      assert {:error, _changeset} = Accounts.create_user(@invalid_attrs)
    end
  end

  describe "update_user/2" do
    @valid_attrs %{
      "name" => "updateuser@name.com"
    }
    @invalid_attrs %{
      "name" => nil
    }

    test "updates a user resource when params are valid", %{
      user: user
    } do
      assert {:ok, user} = Accounts.update_user(user, @valid_attrs)
      assert user.name == @valid_attrs["name"]
    end

    test "returns an error when params are invalid", %{user: user} do
      assert {:error, _changeset} = Accounts.update_user(user, @invalid_attrs)
    end
  end

  describe "delete_user/1" do
    test "deletes a user resource", %{user: user} do
      assert {:ok, user} = Accounts.delete_user(user)
      assert {:ok, nil} = Accounts.find_user(%{"id" => user.id})
      refute is_nil(user.archived_at)
    end
  end
end

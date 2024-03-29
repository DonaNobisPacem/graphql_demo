defmodule GraphqlDemoWeb.UserSocket do
  use Phoenix.Socket
  use Absinthe.Phoenix.Socket, schema: GraphqlDemoWeb.Graphql.Schema
  alias GraphqlDemo.Accounts

  ## Channels
  # channel "room:*", GraphqlDemoWeb.RoomChannel

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  def connect(%{"Authorization" => "Bearer " <> email} = _params, socket, _connect_info) do
    context =
      case Accounts.find_user(%{"email" => email}) do
        {:ok, user} -> %{current_user: user}
        {:error, _message} -> %{}
      end

    socket = Absinthe.Phoenix.Socket.put_options(socket, context: context)
    {:ok, socket}
  end

  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     GraphqlDemoWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(_socket), do: nil
end

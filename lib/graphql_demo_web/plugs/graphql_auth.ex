defmodule GraphqlDemoWeb.Plugs.GraphqlAuth do
  @behaviour Plug

  import Plug.Conn
  alias GraphqlDemo.Accounts

  def init(opts), do: opts

  def call(conn, _params) do
    context = build_context(conn)

    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    with ["Bearer " <> email] <- get_req_header(conn, "authorization"),
         {:ok, user} <- Accounts.find_user(%{"email" => email}) do
      %{current_user: user}
    else
      _ ->
        %{}
    end
  end
end

defmodule GraphqlDemoWeb.Router do
  use GraphqlDemoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GraphqlDemoWeb do
    pipe_through :api
  end

  scope "/graphiql" do
    pipe_through([:api])

    forward("/", Absinthe.Plug.GraphiQL,
      schema: GraphqlDemoWeb.Graphql.Schema,
      socket: GraphqlDemoWeb.UserSocket
    )
  end
end

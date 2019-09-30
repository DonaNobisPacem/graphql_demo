defmodule GraphqlDemoWeb.Router do
  use GraphqlDemoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GraphqlDemoWeb do
    pipe_through :api
  end
end

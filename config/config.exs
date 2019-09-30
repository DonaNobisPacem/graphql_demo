# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :graphql_demo,
  ecto_repos: [GraphqlDemo.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :graphql_demo, GraphqlDemoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bHylEQwbRmlIRoF3+KBfbzPINb32kflJxqDmGAS6TpOrcp3cRqNX/j44Ep1LJEyS",
  render_errors: [view: GraphqlDemoWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: GraphqlDemo.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

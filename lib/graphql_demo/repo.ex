defmodule GraphqlDemo.Repo do
  use Ecto.Repo,
    otp_app: :graphql_demo,
    adapter: Ecto.Adapters.Postgres
end

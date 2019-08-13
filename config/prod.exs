use Mix.Config

# Do not print debug messages in production
config :logger, level: :info

# # Configure your database
# config :rates, Rates.Repo,
#   adapter: Ecto.Adapters.Postgres,
#   username: "postgres",
#   password: "postgres",
#   database: "rates_prod",
#   hostname: "localhost",
#   pool: Ecto.Adapters.SQL.Sandbox

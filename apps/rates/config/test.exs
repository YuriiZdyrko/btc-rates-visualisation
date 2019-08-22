# Since configuration is shared in umbrella projects, this file
# should only configure the :rates application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# Configure your database
config :rates, Rates.Repo,
  username: System.get_env("POSTGRES_USER") || "postgres",
  password: System.get_env("POSTGRES_PASSWORD") || "postgres",
  database: System.get_env("POSTGRES_DB") || "rates_test",
  hostname: System.get_env("POSTGRES_HOST") || "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :rates, :ticker_api, Rates.Mocks.Ticker

config :tesla, adapter: Tesla.Mock

# Since configuration is shared in umbrella projects, this file
# should only configure the :rates_web application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# General application configuration
config :rates_web,
  namespace: RatesWeb,
  ecto_repos: [Rates.Repo],
  generators: [context_app: :rates]

# Configures the endpoint
config :rates_web, RatesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "y7+DkSLDECopsNueqWeOg2/7vYSHtcMpUM41YPp+06aaF+VD+km82CYsuTULMSgE",
  render_errors: [view: RatesWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: RatesWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

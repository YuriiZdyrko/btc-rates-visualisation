# Since configuration is shared in umbrella projects, this file
# should only configure the :rates application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

config :rates,
  namespace: Rates,
  ecto_repos: [Rates.Repo]

import_config "#{Mix.env()}.exs"

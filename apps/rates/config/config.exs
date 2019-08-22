# Since configuration is shared in umbrella projects, this file
# should only configure the :rates application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

config :rates,
  namespace: Rates,
  ecto_repos: [Rates.Repo]

config :rates, Rates.Scheduler,
  jobs: [
    # Every minute
    {"*/2 * * * *", {Rates.DataUpdater, :update, []}}
  ]

import_config "#{Mix.env()}.exs"

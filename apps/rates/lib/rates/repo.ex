defmodule Rates.Repo do
  use Ecto.Repo,
    otp_app: :rates,
    adapter: Ecto.Adapters.Postgres
end

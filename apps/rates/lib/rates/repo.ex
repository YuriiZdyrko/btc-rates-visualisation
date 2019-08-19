defmodule Rates.Repo do
  use Ecto.Repo,
    otp_app: :rates,
    adapter: Ecto.Adapters.Postgres

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    if url = System.get_env("DB_URL") do
      IO.puts("---------------------------EXITS!!!!")
      IO.inspect(System.get_env("DB_URL"))
      {:ok, Keyword.put(opts, :url, url)}
    else
      IO.puts("---------------------------FUCKCKKCKKC")
      {:ok, opts}
    end
  end
end

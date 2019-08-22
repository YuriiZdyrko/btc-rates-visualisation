defmodule Rates.DataUpdater.Client do
  @moduledoc """
  HTTP client to fetch latest Blockchain currencies rates
  """

  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://api.coinmarketcap.com")
  plug(Tesla.Middleware.JSON)

  @doc """
  Returns JSON, containing a list of rates
  """
  def get do
    get("/v1/ticker/")
  end
end

defmodule Rates.DataUpdater.Client do
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://api.coinmarketcap.com")
  plug(Tesla.Middleware.JSON)

  def get do
    get("/v1/ticker/")
  end
end

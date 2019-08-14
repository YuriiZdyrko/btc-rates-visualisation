defmodule Rates.Mocks.Service do
  def get(params) do
      {:ok,
      [
        # {
        #     "id": "bitcoin",
        #     "name": "Bitcoin",
        #     "symbol": "BTC",
        #     "rank": "1",
        #     "price_usd": "10667.7055595",
        #     "price_btc": "1.0",
        #     "24h_volume_usd": "15360879490.4",
        #     "market_cap_usd": "190811777199",
        #     "available_supply": "17886862.0",
        #     "total_supply": "17886862.0",
        #     "max_supply": "21000000.0",
        #     "percent_change_1h": "-0.3",
        #     "percent_change_24h": "-0.32",
        #     "percent_change_7d": "-4.9",
        #     "last_updated": "1566299793"
        # },
        # {
        #     "id": "ethereum",
        #     "name": "Ethereum",
        #     "symbol": "ETH",
        #     "rank": "2",
        #     "price_usd": "197.18063779",
        #     "price_btc": "0.01847719",
        #     "24h_volume_usd": "6004455065.37",
        #     "market_cap_usd": "21176764816.0",
        #     "available_supply": "107397790.0",
        #     "total_supply": "107397790.0",
        #     "max_supply": null,
        #     "percent_change_1h": "-0.2",
        #     "percent_change_24h": "-1.76",
        #     "percent_change_7d": "-5.71",
        #     "last_updated": "1566299784"
        # }
      ]
    }
  end
end

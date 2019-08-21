defmodule Rates.DataGetterTest do
  use ExUnit.Case

  alias Rates.Repo
  alias Rates.Models.Rate
  alias Rates.Models.Currency

  @rate_1_price Decimal.new(1.99)
  @rate_2_price Decimal.new(100.99)
  @rate_3_price Decimal.new(2.99)
  @rate_4_price Decimal.new(200.99)

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Rates.Repo)

    currencies = [
      currency_btc = %Currency{
        id: "btc",
        name: "Bitcoin",
        symbol: "BTC"
      },
      currency_eth = %Currency{
        id: "eth",
        name: "Ethereum",
        symbol: "ETH"
      }
    ] |> Enum.map(&Repo.insert!/1)

    rates = [
      %Rate{
        price_usd: @rate_4_price,
        refreshed_at: ~U[2019-08-21 14:05:00Z],
        currency_id: currency_eth.id
      },
      %Rate{
        price_usd: @rate_3_price,
        refreshed_at: ~U[2019-08-21 14:03:59Z],
        currency_id: currency_btc.id
      },
      %Rate{
        price_usd: @rate_2_price,
        refreshed_at: ~U[2019-08-21 14:02:00Z],
        currency_id: currency_eth.id
      },
      %Rate{
        price_usd: @rate_1_price,
        refreshed_at: ~U[2019-08-21 14:01:00Z],
        currency_id: currency_btc.id
      }
    ] |> Enum.map(&Repo.insert!/1)

    :ok
  end

  test "returns correct result" do
    assert %{
              currencies: ["Bitcoin", "Ethereum"],
              prices: prices
            } = Rates.DataGetter.get_chart(~U[2019-08-21 14:00:00Z], ~U[2019-08-21 14:05:00Z], "minute")

    assert prices == [
      [~U[2019-08-21 14:00:00.000000Z], nil, nil],
      [~U[2019-08-21 14:01:00.000000Z], @rate_1_price, nil],
      [~U[2019-08-21 14:02:00.000000Z], @rate_1_price, @rate_2_price],
      [~U[2019-08-21 14:03:00.000000Z], @rate_1_price, @rate_2_price],
      [~U[2019-08-21 14:04:00.000000Z], @rate_3_price, @rate_2_price],
      [~U[2019-08-21 14:05:00.000000Z], @rate_3_price, @rate_4_price]
    ]
  end
end

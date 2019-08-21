defmodule Rates.DataGetterTest do
  use ExUnit.Case

  alias Rates.Repo
  alias Rates.Models.Rate
  alias Rates.Models.Currency

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Rates.Repo)

    currencies = [
      currency_1 = %Currency{
        id: "btc",
        name: "Bitcoin",
        symbol: "BTC"
      },
      currency_2 = %Currency{
        id: "eth",
        name: "Ethereum",
        symbol: "ETH"
      }
    ] |> Enum.map(&Repo.insert!/1)

    rates = [
      %Rate{
        price_usd: Decimal.new(1.99),
        refreshed_at: ~U[2019-08-21 15:00:00Z],
        currency_id: currency_1.id
      },
      %Rate{
        price_usd: Decimal.new(2.99),
        refreshed_at: ~U[2019-08-21 15:00:00Z],
        currency_id: currency_2.id
      },
      %Rate{
        price_usd: Decimal.new(3.99),
        refreshed_at: ~U[2019-08-21 14:00:00Z],
        currency_id: currency_2.id
      }
    ] |> Enum.map(&Repo.insert!/1)

    :ok
  end

  test "returns correct result" do
    # assert 1 == 0 + 1
    # assert Repo.aggregate(Currency, :count, :id) == 2

    assert %{
              currencies: ["Bitcoin", "Ethereum"],
              prices: prices
            } = Rates.DataGetter.get_chart(84600, "hour")

    assert length(prices) == 61

    assert [

    ]
  end

  # defp with_timestamps(list) do
  #   now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
  #
  #   list
  #   |> Enum.map(fn map ->
  #     Map.merge(map, %{
  #       inserted_at: now,
  #       updated_at: now
  #     })
  #   end)
  # end
end

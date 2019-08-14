defmodule Rates.DataUpdaterTest do
  use ExUnit.Case

  alias Rates.Repo
  alias Rates.Models.Rate
  alias Rates.Models.Currency

  @mock_response_body [
    _new_currency_new_rate = %{
       "id" => "cosmos",
       "name" => "Cosmos",
       "symbol" => "ATOM",
       "price_usd" => "2.22222",
       "last_updated" => "1566314049"
   },
  _new_currency_new_rate = %{
      "id" => "btc",
      "name" => "Bitcoin",
      "symbol" => "BTC",
      "price_usd" => "1.111111",
      "last_updated" => "1566314043"
    },
    _existing_currency_new_rate_ = %{
       "id" => "cosmos",
       "name" => "Cosmos",
       "symbol" => "ATOM",
       "price_usd" => "3.33333",
       "last_updated" => "156634444"
   },
   _existing_currency_existing_rate = %{
      "id" => "btc",
      "name" => "Bitcoin",
      "symbol" => "BTC",
      "price_usd" => "1.111111",
      "last_updated" => "1566314043"
    }
  ]

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Rates.Repo)

    Tesla.Mock.mock(fn %{method: :get} ->
      %Tesla.Env{status: 200, body: @mock_response_body}
    end)

    :ok
  end

  test "saves currencies and rates in db, ignores existing items" do
    assert :ok = Rates.DataUpdater.update()
    assert Repo.aggregate(Currency, :count, :id) == 2
    assert Repo.aggregate(Rate, :count, :id) == 3
  end
end

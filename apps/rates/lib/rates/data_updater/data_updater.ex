defmodule Rates.DataUpdater do
  @moduledoc """
  Fetches list of rates, inserts new values into database
  """

  alias Rates.DataUpdater.Client
  alias Rates.Models.Currency
  alias Rates.Models.Rate
  alias Rates.Repo

  def update do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    with {:ok, response} <- Client.get() do
      currencies =
        response.body
        |> Enum.map(fn item ->
          %{
            id: item["id"],
            name: item["name"],
            symbol: item["symbol"],
            inserted_at: now,
            updated_at: now
          }
        end)

      rates =
        response.body
        |> Enum.map(fn item ->
          {last_updated, _} = Integer.parse(item["last_updated"])

          %{
            refreshed_at: DateTime.from_unix!(last_updated),
            price_usd: Decimal.new(item["price_usd"]),
            currency_id: item["id"],
            inserted_at: now,
            updated_at: now
          }
        end)

      Repo.insert_all(Currency, currencies, on_conflict: :nothing)
      Repo.insert_all(Rate, rates, on_conflict: :nothing)

      :ok
    end
  end
end

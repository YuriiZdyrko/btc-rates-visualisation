defmodule Rates.DataGetter do

  @moduledoc """
  Gets rates from database, filtered by range parameter
  """

  import Ecto.Query

  alias Rates.Repo
  alias Rates.Models.Rate
  alias Rates.Models.Currency


  # def get(range) do
  #   since = Timex.shift(Timex.now(), seconds: -range)
  #   till = Timex.now()
  #
  #   Rate
  #   |> where([r], fragment(
  #     "? BETWEEN ? AND ?",
  #     r.refreshed_at,
  #     ^since,
  #     ^till
  #   ))
  #   |> Repo.all()
  # end


  # def test do
  #   get_chart(3600, "minute")
  # end

  @spec get_chart(number, string) :: []
  def get_chart(duration, x_unit) when
    is_integer(duration)
    and duration > 0
    and x_unit in ["second", "minute", "hour"]
  do
    now = Timex.now()

    series_start = now
    |> Timex.shift(seconds: -duration)
    |> DateTime.to_naive()

    series_end = now
    |> DateTime.to_naive()

    prices_query_result = Ecto.Adapters.SQL.query!(
      Rates.Repo,
      "SELECT series, array_agg(r.price_usd ORDER BY c.name ASC) FROM (SELECT id, name from currencies) c
      CROSS JOIN generate_series($1::timestamp, $2::timestamp, ('1 ' || $3)::interval) series
      LEFT JOIN LATERAL (
        SELECT id, price_usd, refreshed_at from rates WHERE rates.currency_id = c.id and refreshed_at < series ORDER BY rates.refreshed_at DESC LIMIT 1
      ) r ON true
      GROUP BY series",
      [series_start, series_end, x_unit]
    )

    %Postgrex.Result{
      rows: prices_rows
    } = prices_query_result

    currencies_names = Currency
    |> order_by(asc: :name)
    |> select([c], c.name)
    |> Repo.all()

    %{
      currencies: currencies_names,
      prices: prices_rows
      |> Enum.map(fn [date, prices] ->
        [date] ++ prices
      end)
    }
  end
end

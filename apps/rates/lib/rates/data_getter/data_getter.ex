defmodule Rates.DataGetter do
  @moduledoc """
  Gets prices chart data from database
  """

  import Ecto.Query

  alias Rates.Repo
  alias Rates.Models.Currency

  @spec get_chart(any(), any(), String.t()) :: []
  def get_chart(since, till, unit)
      when since < till and unit in ["second", "minute", "hour"] do
    prices_query = """
      SELECT
        series::timestamp at time zone 'Etc/UTC',
        array_agg(rates.price_usd ORDER BY c.name ASC)
      FROM
        (SELECT id, name FROM currencies) c
        CROSS JOIN
          generate_series(
            $1::timestamp,
            $2::timestamp,
            ('1 ' || $3)::interval
          ) series
        LEFT JOIN LATERAL (
          SELECT id, price_usd, refreshed_at from rates
            WHERE rates.currency_id = c.id AND refreshed_at <= series
            ORDER BY rates.refreshed_at DESC
            LIMIT 1
        ) rates ON true
      GROUP BY series
    """

    prices_query_result =
      Ecto.Adapters.SQL.query!(
        Rates.Repo,
        prices_query,
        [since, till, unit]
      )

    %Postgrex.Result{
      rows: prices_rows
    } = prices_query_result

    currencies_names =
      Currency
      |> order_by(asc: :name)
      |> select([c], c.name)
      |> Repo.all()

    %{
      currencies: currencies_names,
      prices:
        prices_rows
        |> Enum.map(fn [date, prices] ->
          [date] ++ prices
        end)
    }
  end
end

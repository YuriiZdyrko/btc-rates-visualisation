defmodule RatesWeb.RatesController do
  use RatesWeb, :controller

  def index(conn, %{"since" => since, "till" => till, "unit" => unit}) do
    # {duration, _} = Integer.parse(duration)
    json(conn, Rates.DataGetter.get_chart(parse_datetime(since), parse_datetime(till), unit))
  end

  defp parse_datetime(date) do
    {:ok, result} = Timex.parse(date, "{ISO:Extended}")
    result
  end
end

defmodule RatesWeb.RatesController do
  use RatesWeb, :controller

  def index(conn, %{"duration" => duration, "unit" => unit}) do
    {duration, _} = Integer.parse(duration)
    json(conn, Rates.DataGetter.get_chart(duration, unit))
  end
end

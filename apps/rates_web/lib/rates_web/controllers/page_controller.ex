defmodule RatesWeb.PageController do
  use RatesWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

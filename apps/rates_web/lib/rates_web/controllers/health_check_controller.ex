defmodule RatesWeb.HealthCheckController do
  use RatesWeb, :controller

  def index(conn, _params) do
    send_resp(conn, 200, "")
  end
end

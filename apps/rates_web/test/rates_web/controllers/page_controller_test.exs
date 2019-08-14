defmodule RatesWeb.PageControllerTest do
  use RatesWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Rates"
  end
end

defmodule RatesWeb.Router do
  use RatesWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", RatesWeb do
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  scope "/api", RatesWeb do
    pipe_through(:api)

    get("/rates", RatesController, :index)
  end
end

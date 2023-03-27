defmodule PhoenixParsingMarketDataWeb.PageController do
  use PhoenixParsingMarketDataWeb, :controller
  alias Currencies.Parse
  alias Currencies.Top
  alias PhoenixParsingMarketData.CurrencyContext

  def insert_database_rows() do
    CurrencyContext.insert_currency("RON", "Romanian currency")
    CurrencyContext.insert_currency("EUR", "European currency")
    CurrencyContext.insert_currency("USD", "American currency")
  end

  def home(conn, _params) do
    render(conn, :home, layout: false)
  end

end

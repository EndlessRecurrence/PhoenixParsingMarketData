defmodule PhoenixParsingMarketDataWeb.PageController do
  use PhoenixParsingMarketDataWeb, :controller
  alias Currencies.Parse
  alias Currencies.Top
  alias PhoenixParsingMarketData.CurrencyContext

  def insert_database_rows() do
    CurrencyContext.insert_currency("RON", "Romanian leu")
    CurrencyContext.insert_currency("EUR", "European euro")
    CurrencyContext.insert_currency("USD", "American dollar")
    CurrencyContext.insert_currency("CAD", "Canadian dollar")
    CurrencyContext.insert_currency("BGN", "Bulgarian lev")
    CurrencyContext.insert_currency("JPY", "Japanese yen")
    CurrencyContext.insert_currency("AED", "United Arab Emirates dirham")
    CurrencyContext.insert_currency("PLN", "Polish zloty")
    CurrencyContext.insert_currency("RUB", "Russian ruble")
    CurrencyContext.insert_currency("SEK", "Swedish kronor")
    CurrencyContext.insert_currency("UAH", "Ukraininan hryvnia")
    CurrencyContext.insert_currency("ZWL", "Zimbabwean dollar")
  end

  def home(conn, _params) do
    insert_database_rows()
    render(conn, :home, layout: false)
  end

end

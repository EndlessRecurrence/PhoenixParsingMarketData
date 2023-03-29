defmodule PhoenixParsingMarketDataWeb.PageController do
  use PhoenixParsingMarketDataWeb, :controller
  alias Currencies.Parse
  alias Currencies.Top
  alias PhoenixParsingMarketData.CurrencyContext

  def insert_database_rows() do
    CurrencyContext.create_currency(%{:name => "RON", :description=> "Romanian leu"})
    CurrencyContext.create_currency(%{:name => "EUR", :description => "European euro"})
    CurrencyContext.create_currency(%{:name => "USD", :description => "American dollar"})
    CurrencyContext.create_currency(%{:name => "CAD", :description => "Canadian dollar"})
    CurrencyContext.create_currency(%{:name => "ZWL", :description => "Zimbabwean dollar"})
  end

  def home(conn, _params) do
    insert_database_rows()
    render(conn, :home, layout: false)
  end

end

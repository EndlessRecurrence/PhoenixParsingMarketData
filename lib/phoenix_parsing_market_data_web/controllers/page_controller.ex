defmodule PhoenixParsingMarketDataWeb.PageController do
  use PhoenixParsingMarketDataWeb, :controller
  alias Currencies.Parse, as: Parse
  alias Currencies.Top, as: Top
  alias PhoenixParsingMarketData.CurrencyContext

  def get_objects() do
    Parse.run(["--path=assets/data.txt"])
    Top.run(["--count=3", "--column=changePercent"])
  end

  def convert_value_to_string(value) do
    cond do
      is_integer(value) -> Integer.to_string(value)
      is_float(value) -> Float.to_string(value)
      true -> value
    end
  end

  def get_columns(objects) do
    Enum.at(objects, 0) |> Enum.map(fn {x, _} -> x end)
  end

  def insert_database_rows() do
    CurrencyContext.insert_currency("RON", "Romanian currency")
    CurrencyContext.insert_currency("EUR", "European currency")
    CurrencyContext.insert_currency("USD", "American currency")
  end

  def home(conn, _params) do
    objects = get_objects()
    columns = get_columns(objects)
    number_of_objects = Enum.count(objects)
    number_of_columns = Enum.count(columns)
    objects_with_string_properties =
      Enum.map(objects, fn x ->
        Enum.map(x, fn {x, y} -> {x, convert_value_to_string(y)} end) |> Enum.into(%{})
      end)

    insert_database_rows()

    render(conn, :home, layout: false,
      top_currencies: objects_with_string_properties,
      columns: columns,
      number_of_objects: number_of_objects - 1,
      number_of_columns: number_of_columns - 1)
  end

end

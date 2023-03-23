defmodule PhoenixParsingMarketDataWeb.PageController do
  use PhoenixParsingMarketDataWeb, :controller
  alias Currencies.Parse, as: Parse
  alias Currencies.Top, as: Top

  def get_objects() do
    Parse.run(["--path=assets/data.txt"])
    Top.run(["--count=3", "--column=changePercent"])
  end

  def display_object(object) do
    "{" <> Enum.reduce(object, "", fn {x, y}, acc ->
        cond do
          is_float(y) -> acc <> x <> ": " <> Float.to_string(y) <> ","
          is_integer(y) -> acc <> x <> ": " <> Integer.to_string(y) <> ","
          true -> acc <> x <> ": " <> y <> ","
        end
      end)
    <> "}"
  end

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    objects = get_objects()
    objects_as_strings = Enum.reduce(objects, "", fn x, acc -> acc <> display_object(x) <> ";" end)
    render(conn, :home, layout: false, top_currencies: objects_as_strings)
  end

end

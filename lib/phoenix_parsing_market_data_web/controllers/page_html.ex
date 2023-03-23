defmodule PhoenixParsingMarketDataWeb.PageHTML do
  use PhoenixParsingMarketDataWeb, :html
  alias Currencies.Parse, as: Parse
  alias Currencies.Top, as: Top

  embed_templates "page_html/*"
end

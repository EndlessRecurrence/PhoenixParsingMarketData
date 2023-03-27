defmodule PhoenixParsingMarketDataWeb.CurrencyHTML do
  use PhoenixParsingMarketDataWeb, :html

  embed_templates "currency_html/*"

  @doc """
  Renders a currency form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def currency_form(assigns)
end

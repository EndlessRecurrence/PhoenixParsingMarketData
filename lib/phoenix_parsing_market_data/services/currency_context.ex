defmodule PhoenixParsingMarketData.CurrencyContext do
  alias PhoenixParsingMarketData.Repo

  def insert_currency(name) do
    currency = %PhoenixParsingMarketData.Currency{}
    changeset = PhoenixParsingMarketData.Currency.changeset(currency, %{name: name})
    Repo.insert(changeset)
  end

  def fetch_currencies() do
    PhoenixParsingMarketData.Currency
    |> Ecto.Query.first()
    |> Repo.all()
  end
end

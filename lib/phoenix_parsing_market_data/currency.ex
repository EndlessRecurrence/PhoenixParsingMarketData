defmodule PhoenixParsingMarketData.CurrencyContext do
  alias PhoenixParsingMarketData.Repo
  alias PhoenixParsingMarketData.Currencies.Currency, as: Currency
  alias PhoenixParsingMarketData.ValueContext
  import Ecto.Query

  def insert_currency(name, description) do
    currency = %Currency{}
    changeset = Currency.changeset(currency, %{name: name, description: description})
    IO.inspect Repo.insert(changeset)

    value = :rand.uniform() * 10 |> Float.round(4)
    currency = from(c in Currency, where: [name: ^name]) |> Repo.one()
    IO.inspect(currency)
    generate_random_currency_values(currency, 100, ~D[2023-01-01], value)
  end

  def generate_random_currency_values(_, 0, _, _), do: :ok
  def generate_random_currency_values(currency, days, day, value) do
    id = currency |> Map.get(:id)
    IO.inspect ValueContext.insert_value(id, day, value), label: :value_label
    negative_or_positive = if :rand.uniform() < 0.5, do: -1, else: 1
    variation = :rand.uniform() * 0.1 * negative_or_positive |> Float.round(4)
    IO.puts(Integer.to_string(id) <> " " <> Float.to_string(value))
    generate_random_currency_values(currency, days - 1, Date.add(day, 1), value + variation)
  end
end

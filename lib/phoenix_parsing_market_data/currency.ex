defmodule PhoenixParsingMarketData.CurrencyContext do
  alias PhoenixParsingMarketData.Repo
  alias PhoenixParsingMarketData.Currencies.Currency, as: Currency
  alias PhoenixParsingMarketData.ValueContext
  import Ecto.Query

  def insert_currency(name, description) do
    currency = %Currency{}
    Currency.changeset(currency, %{name: name, description: description})
      |> Repo.insert()

    value = :rand.uniform() * 10 |> Float.round(4)
    currency = from(c in Currency, where: [name: ^name]) |> Repo.one()
    generate_random_currency_values(currency, 365, ~D[2023-01-01], value)
  end

  @spec generate_random_currency_values(any, non_neg_integer, any, any) :: :ok
  def generate_random_currency_values(_, 0, _, _), do: :ok
  def generate_random_currency_values(currency, days, day, value) do
    id = currency |> Map.get(:id)
    ValueContext.insert_value(id, day, value)
    negative_or_positive = if :rand.uniform() < 0.5, do: -1, else: 1
    variation = :rand.uniform() * 0.1 * negative_or_positive |> Float.round(4)
    new_value = if value + variation < 0, do: value - variation, else: value + variation
    generate_random_currency_values(currency, days - 1, Date.add(day, 1), new_value)
  end

  def fetch_currencies() do
    from(c in Currency, select: c) |> Repo.all()
  end

  def get_currency!(id) when is_integer(id) do
    from(c in Currency, where: [id: ^id])
      |> Repo.one()
      |> Repo.preload(:values)
  end
  def get_currency!(_), do: raise RuntimeError, message: "The id given to the get_currency function is not an integer."

  def compare_two_currencies(first_currency_id, second_currency_id) do
    first_currency = get_currency!(String.to_integer(first_currency_id))
    second_currency = get_currency!(String.to_integer(second_currency_id))

    first_currency_values_structs =
      Map.get(first_currency, :values) |>
      Enum.sort(fn x, y -> Date.compare(Map.get(x, :date), Map.get(y, :date)) != :lt end)
    second_currency_values_structs =
      Map.get(second_currency, :values) |>
      Enum.sort(fn x, y -> Date.compare(Map.get(x, :date), Map.get(y, :date)) != :lt end)
    dates = Enum.map(first_currency_values_structs, fn x -> Map.get(x, :date) end)

    first_currency_values = Enum.map(first_currency_values_structs, &Map.get(&1, :value))
    second_currency_values = Enum.map(second_currency_values_structs, &Map.get(&1, :value))

    conversion_rates =
      Enum.zip(first_currency_values, second_currency_values)
        |> Enum.reduce([], fn {x, y}, acc ->
          element = x / y
          acc ++ [element]
        end)

    %{
      first_currency: Map.get(first_currency, :name),
      second_currency: Map.get(second_currency, :name),
      dates: dates,
      first_currency_values: first_currency_values,
      second_currency_values: second_currency_values,
      conversion_rates: conversion_rates
    }
  end
end

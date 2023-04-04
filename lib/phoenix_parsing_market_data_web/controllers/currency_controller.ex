defmodule PhoenixParsingMarketDataWeb.CurrencyController do
  use PhoenixParsingMarketDataWeb, :controller

  alias PhoenixParsingMarketData.CurrencyContext
  alias PhoenixParsingMarketData.Currencies.Currency

  def index(conn, _params) do
    currencies = CurrencyContext.fetch_currencies()
    render(conn, :index, currencies: currencies)
  end

  def new(conn, _params) do
    changeset = CurrencyContext.change_currency(%Currency{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"currency" => currency_params}) do
    IO.inspect currency_params
    case CurrencyContext.create_currency(currency_params) do
      {:ok, currency} ->
        conn
          |> put_flash(:info, "Currency created successfully.")
          |> redirect(to: ~p"/currencies/show/#{currency}")
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    currency = CurrencyContext.get_currency!(String.to_integer(id))
    currencies = CurrencyContext.fetch_currencies() |> Enum.filter(fn x -> Map.get(x, :name) != Map.get(currency, :name) end)
    default_date_interval = CurrencyContext.get_default_date_interval()
    interval_as_unwrapped_objects = {
      Map.get(elem(default_date_interval, 0), :min_date),
      Map.get(elem(default_date_interval, 1), :max_date)
    }
    IO.inspect interval_as_unwrapped_objects, label: "Unwrapped date objects"

    render(conn, :show, currency: currency, currencies: currencies, default_date_interval: interval_as_unwrapped_objects)
  end

  def compare(conn, %{"first_id" => first_id, "second_id" => second_id, "first_date" => first_date_as_string, "second_date" => second_date_as_string}) do
    {_, first_date} = Date.from_iso8601(first_date_as_string)
    {_, second_date} = Date.from_iso8601(second_date_as_string)
    table_values = CurrencyContext.compare_two_currencies(first_id, second_id, first_date, second_date)
    {oldest_date, newest_date} = CurrencyContext.get_default_date_interval()
    {oldest_date_in_slash_format, newest_date_in_slash_format} = CurrencyContext.get_default_date_interval_in_slash_format()
    IO.inspect oldest_date_in_slash_format, label: :oldest_date_in_slash_format
    IO.inspect newest_date_in_slash_format, label: :newest_date_in_slash_format

    render(conn, :compare,
          table_values: table_values,
          oldest_date: oldest_date,
          newest_date: newest_date,
          newest_date_in_slash_format: newest_date_in_slash_format,
          oldest_date_in_slash_format: oldest_date_in_slash_format)
  end

  def edit(conn, %{"id" => id}) do
    currency = CurrencyContext.get_currency!(String.to_integer(id))
    changeset = CurrencyContext.change_currency(currency)
    render(conn, :edit, currency: currency, changeset: changeset)
  end

  def update(conn, %{"id" => id, "currency" => currency_params}) do
    currency = CurrencyContext.get_currency!(String.to_integer(id))

    case CurrencyContext.update_currency(currency, currency_params) do
      {:ok, currency} ->
        conn
        |> put_flash(:info, "Currency updated successfully.")
        |> redirect(to: ~p"/currencies/show/#{currency}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, currency: currency, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    currency = CurrencyContext.get_currency!(String.to_integer(id))
    {:ok, _currency} = CurrencyContext.delete_currency(currency)

    conn
    |> put_flash(:info, "Currency deleted successfully.")
    |> redirect(to: ~p"/currencies")
  end
end

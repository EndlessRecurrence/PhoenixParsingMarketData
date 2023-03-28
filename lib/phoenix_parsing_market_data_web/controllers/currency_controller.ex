defmodule PhoenixParsingMarketDataWeb.CurrencyController do
  use PhoenixParsingMarketDataWeb, :controller
  require Protocol

  alias PhoenixParsingMarketData.CurrencyContext
  alias PhoenixParsingMarketData.Currencies.Currency

  def index(conn, _params) do
    currencies = CurrencyContext.fetch_currencies()
    render(conn, :index, currencies: currencies)
  end

  def new(conn, _params) do
    render(conn, :new)
  end

  def create(conn, %{"name" => name, "description" => description}) do
    {_, currency} = CurrencyContext.insert_currency(name, description)
    json(conn, currency)
  end

  def show(conn, %{"id" => id}) do
    currency = CurrencyContext.get_currency!(String.to_integer(id))
    currencies = CurrencyContext.fetch_currencies() |> Enum.filter(fn x -> Map.get(x, :name) != Map.get(currency, :name) end)

    render(conn, :show, currency: currency, currencies: currencies)
  end

  @spec compare(Plug.Conn.t(), map) :: Plug.Conn.t()
  def compare(conn, %{"first_id" => first_id, "second_id" => second_id}) do
    table_values = CurrencyContext.compare_two_currencies(first_id, second_id)
    render(conn, :compare, table_values: table_values)
  end

  #def edit(conn, %{"id" => id}) do
  #  currency = CurrencyContext.get_currency!(id)
  #  changeset = CurrencyContext.change_currency(currency)
  #  render(conn, :edit, currency: currency, changeset: changeset)
  #end

  #def update(conn, %{"id" => id, "currency" => currency_params}) do
  #  currency = CurrencyContext.get_currency!(id)

  #  case CurrencyContext.update_currency(currency, currency_params) do
  #    {:ok, currency} ->
  #      conn
  #      |> put_flash(:info, "Currency updated successfully.")
  #      |> redirect(to: ~p"/currencies/#{currency}")

  #    {:error, %Ecto.Changeset{} = changeset} ->
  #      render(conn, :edit, currency: currency, changeset: changeset)
  #  end
  #end

  #def delete(conn, %{"id" => id}) do
  #  currency = CurrencyContext.get_currency!(id)
  #  {:ok, _currency} = CurrencyContext.delete_currency(currency)

  #  conn
  #  |> put_flash(:info, "Currency deleted successfully.")
  #  |> redirect(to: ~p"/currencies")
  #end
end

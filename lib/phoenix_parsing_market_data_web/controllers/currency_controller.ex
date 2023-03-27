defmodule PhoenixParsingMarketDataWeb.CurrencyController do
  use PhoenixParsingMarketDataWeb, :controller

  alias PhoenixParsingMarketData.CurrencyContext
  alias PhoenixParsingMarketData.Currencies.Currency

  def index(conn, _params) do
    currencies = CurrencyContext.fetch_currencies()
    render(conn, :index, currencies: currencies)
  end

  #def new(conn, _params) do
  #  changeset = CurrencyContext.change_currency(%Currency{})
  #  render(conn, :new, changeset: changeset)
  #end

  #def create(conn, %{"currency" => currency_params}) do
  #  case CurrencyContext.create_currency(currency_params) do
  #    {:ok, currency} ->
  #      conn
  #      |> put_flash(:info, "Currency created successfully.")
  #      |> redirect(to: ~p"/currencies/#{currency}")

  #    {:error, %Ecto.Changeset{} = changeset} ->
  #      render(conn, :new, changeset: changeset)
  #  end
  #end

  def show(conn, %{"id" => id}) do
    currency = CurrencyContext.get_currency!(String.to_integer(id))
    IO.inspect currency
    render(conn, :show, currency: currency)
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

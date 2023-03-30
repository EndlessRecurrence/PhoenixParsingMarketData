defmodule PhoenixParsingMarketDataWeb.ValueController do
  use PhoenixParsingMarketDataWeb, :controller

  alias PhoenixParsingMarketData.ValueContext
  alias PhoenixParsingMarketData.Values.Value

  def show(conn, %{"id" => id}) do
    value = ValueContext.get_value!(String.to_integer(id))
    render(conn, :show, value: value)
  end

  def edit(conn, %{"id" => id}) do
    value = ValueContext.get_value!(String.to_integer(id))
    changeset = ValueContext.change_value(value)
    render(conn, :edit, value: value, changeset: changeset)
  end

  def update(conn, %{"id" => id, "value" => value_params}) do
    value = ValueContext.get_value!(String.to_integer(id))

    case ValueContext.update_value(value, value_params) do
      {:ok, value} ->
        conn
        |> put_flash(:info, "Value updated successfully.")
        |> redirect(to: ~p"/currencies/show/#{Map.get(value, :currency) |> Map.get(:id)}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, value: value, changeset: changeset)
    end
  end
end

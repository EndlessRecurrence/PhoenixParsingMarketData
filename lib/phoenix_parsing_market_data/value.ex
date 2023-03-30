defmodule PhoenixParsingMarketData.ValueContext do
  alias PhoenixParsingMarketData.Repo
  alias PhoenixParsingMarketData.Values.Value, as: Value
  import Ecto.Query

  def insert_value(currency_id, date, value) do
    value_struct = %Value{}
    changeset = Value.changeset(value_struct, %{currency_id: currency_id, date: date, value: value})
    Repo.insert(changeset)
  end

  def delete_value(%Value{} = value) do
    Repo.delete(value)
  end

  def get_value!(id) when is_integer(id) do
    from(v in Value, where: [id: ^id])
      |> Repo.one()
        |> Repo.preload(:currency)
  end
  def get_value!(_), do: raise RuntimeError, message: "The id should be an integer."

  def change_value(%Value{} = value, attrs \\ %{}) do
    Value.changeset(value, attrs)
  end

  def update_value(%Value{} = value, attrs) do
    value
    |> Value.changeset(attrs)
    |> Repo.update()
  end
end

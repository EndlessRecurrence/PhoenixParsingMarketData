defmodule PhoenixParsingMarketData.ValueContext do
  alias PhoenixParsingMarketData.Repo
  alias PhoenixParsingMarketData.Values.Value, as: Value

  def insert_value(currency_id, date, value) do
    value_struct = %Value{}
    changeset = Value.changeset(value_struct, %{currency_id: currency_id, date: date, value: value})
    Repo.insert(changeset)
  end

  def delete_value(%Value{} = value) do
    Repo.delete(value)
  end
end

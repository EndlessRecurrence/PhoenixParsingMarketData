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

  def get_most_recent_date() do
    from(v in Value)
      |> select([v], %{max_date: max(v.date)})
      |> Repo.one()
  end

  def get_least_recent_date() do
    from(v in Value)
      |> select([v], %{min_date: min(v.date)})
      |> Repo.one()
  end

  def get_today_date() do
    today = Date.utc_today()
    %{max_date: today}
  end

  def get_most_recent_date_in_slash_format() do
    newest_date = get_most_recent_date() |> Map.get(:max_date) |> Date.to_iso8601()
    Regex.replace(~r/(\d+)-(\d+)-(\d+)/, newest_date, "\\3/\\2/\\1")
  end

  def get_least_recent_date_in_slash_format() do
    oldest_date = get_least_recent_date() |> Map.get(:min_date) |> Date.to_iso8601()
    Regex.replace(~r/(\d+)-(\d+)-(\d+)/, oldest_date, "\\3/\\2/\\1")
  end

  def get_today_in_slash_format() do
    today = Date.utc_today() |> Date.to_iso8601()
    Regex.replace(~r/(\d+)-(\d+)-(\d+)/, today, "\\3/\\2/\\1")
  end
end

defmodule PhoenixParsingMarketData.Values.Value do
  use Ecto.Schema
  alias PhoenixParsingMarketData.Currencies.Currency

  schema "values" do
    field :date, :date
    field :value, :float
    belongs_to :currency, Currency
  end

  def changeset(value, params \\ %{}) do
    value
    |> Ecto.Changeset.cast(params, [:currency_id, :date, :value])
    |> Ecto.Changeset.validate_required([:currency_id, :date, :value])
  end

end

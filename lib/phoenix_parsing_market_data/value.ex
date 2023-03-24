defmodule PhoenixParsingMarketData.Value do
  use Ecto.Schema
  alias PhoenixParsingMarketData.Currency

  schema "values" do
    belongs_to :currencies, Currency
    field :date
    field :value

    timestamps()
  end

  def changeset(currency, params \\ %{}) do
    currency
    |> Ecto.Changeset.cast(params, [:currencies, :date, :value])
    |> Ecto.Changeset.validate_required([:currencies, :date, :value])
  end

end

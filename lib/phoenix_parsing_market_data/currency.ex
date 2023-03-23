defmodule PhoenixParsingMarketData.Currency do
  use Ecto.Schema

  schema "currencies" do
    field :name, :string
  end

  def changeset(currency, params \\ %{}) do
    currency
    |> Ecto.Changeset.cast(params, [:name])
    |> Ecto.Changeset.validate_required([:name])
  end

end

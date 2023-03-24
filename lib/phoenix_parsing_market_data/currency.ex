defmodule PhoenixParsingMarketData.Currency do
  use Ecto.Schema

  schema "currencies" do
    field :name, :string
    field :description, :string
  end

  def changeset(currency, params \\ %{}) do
    currency
    |> Ecto.Changeset.cast(params, [:name, :description])
    |> Ecto.Changeset.validate_required([:name, :description])
    |> Ecto.Changeset.unique_constraint(
      :name,
      name: :index_for_duplicate_currencies
    )
  end

end

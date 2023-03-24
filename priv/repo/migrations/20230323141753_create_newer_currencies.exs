defmodule PhoenixParsingMarketData.Repo.Migrations.CreateNewerCurrencies do
  use Ecto.Migration

  def change do
    create table(:currencies) do
      add :name, :string
      add :description, :string
    end
    create (
      unique_index(
        :currencies, ~w(name)a,
        name: :index_for_duplicate_currencies
      )
    )
  end
end

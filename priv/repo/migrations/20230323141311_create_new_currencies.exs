defmodule PhoenixParsingMarketData.Repo.Migrations.CreateNewCurrencies do
  use Ecto.Migration

  def change do
    create table(:currencies) do
      add :name, :string
      add :description, :string
    end
  end
end

defmodule PhoenixParsingMarketData.Repo.Migrations.CreateCurrencies do
  use Ecto.Migration

  def change do
    create table(:currencies) do
      add :name, :string
    end
  end
end

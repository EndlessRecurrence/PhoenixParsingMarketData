defmodule PhoenixParsingMarketData.Repo.Migrations.CreateValuesTable do
  use Ecto.Migration

  def change do
    create table(:values) do
      add :currency_id, references(:currencies)
      add :date, :date
      add :value, :float
    end
  end
end

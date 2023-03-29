defmodule PhoenixParsingMarketData.Repo.Migrations.AddCascadingDelete do
  use Ecto.Migration

  def change do
    drop_if_exists constraint(:values, :values_currency_id_fkey)
    alter table(:values) do
      remove :currency_id
      add :currency_id, references(:currencies, on_delete: :delete_all)
    end
  end
end

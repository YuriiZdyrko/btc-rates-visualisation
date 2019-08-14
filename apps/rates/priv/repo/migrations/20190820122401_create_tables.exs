defmodule Rates.Repo.Migrations.CreateTables do
  use Ecto.Migration

  def change do
    create table(:currencies, primary_key: false) do
      add :id, :string, primary_key: true
      add :name, :string, null: false
      add :symbol, :string, null: false

      timestamps()
    end

    create table(:rates, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :refreshed_at, :utc_datetime, null: false
      add :price_usd, :decimal, null: false
      add :currency_id, references(:currencies, type: :string), null: false

      timestamps()
    end
  end
end

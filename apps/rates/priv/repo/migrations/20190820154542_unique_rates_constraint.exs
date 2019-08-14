defmodule Rates.Repo.Migrations.UniqueRatesConstraint do
  use Ecto.Migration

  def change do
    create unique_index(:rates, [:refreshed_at, :currency_id])
  end
end

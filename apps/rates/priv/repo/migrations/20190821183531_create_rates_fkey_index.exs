defmodule Rates.Repo.Migrations.CreateRatesFkeyIndex do
  use Ecto.Migration

  def change do
    create index(:rates, [:currency_id])
  end
end

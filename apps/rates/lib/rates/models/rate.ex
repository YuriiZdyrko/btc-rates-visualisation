defmodule Rates.Models.Rate do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "rates" do
    field(:refreshed_at, :utc_datetime)
    field(:price_usd, :decimal)

    belongs_to(:currency, Rates.Models.Currency, type: :string)
    timestamps()
  end
end

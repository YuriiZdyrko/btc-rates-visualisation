defmodule Rates.Models.Rate do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  # @derive {Jason.Encoder,
  #          only: [
  #            :id,
  #            :refreshed_at,
  #            :price_usd
  #          ]}

  schema "rates" do
    field(:refreshed_at, :utc_datetime)
    field(:price_usd, :decimal)

    belongs_to(:currency, Rates.Models.Currency, type: :string)
    timestamps()
  end

  # def changeset(params) do
  #   %__MODULE__{}
  #   |> cast(params, [:price_usd, :last_updated])
  #   |> change(refreshed_at: params["last_updated"], currency_id: params["id"])
  #   |> validate_required([:price_usd, :refreshed_at, :currency_id])
  # end
end

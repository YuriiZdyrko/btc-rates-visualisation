defmodule Rates.Models.Currency do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :string, autogenerate: false}

  schema "currencies" do
    field(:name, :string)
    field(:symbol, :string)

    timestamps()
  end

  # def changeset(params) do
  #   %__MODULE__{}
  #   |> cast(params, [:id, :name, :symbol])
  # end
end

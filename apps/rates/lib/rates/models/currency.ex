defmodule Rates.Models.Currency do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :string, autogenerate: false}

  schema "currencies" do
    field(:name, :string)
    field(:symbol, :string)

    timestamps()
  end
end

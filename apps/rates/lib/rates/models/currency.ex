defmodule Rates.Models.Currency do
  @moduledoc """
  Blockchain currency details
  """

  use Ecto.Schema

  @primary_key {:id, :string, autogenerate: false}

  schema "currencies" do
    field(:name, :string)
    field(:symbol, :string)

    timestamps()
  end
end

defmodule Rates.Repo.Migrations.CreateExtensions do
  use Ecto.Migration

  def up do
    """
    CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
    """
  end
end

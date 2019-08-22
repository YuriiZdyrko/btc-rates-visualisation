defmodule Rates.DB do
  @moduledoc """
  Creates and migrates database on application start.
  """

  use Task

  alias Rates.Repo

  def start_link(_) do
    Task.start_link(__MODULE__, :run, [])
  end

  def run() do
    create_db()
    migrate_db()
  end

  defp create_db do
    result = Repo.__adapter__().storage_up(Repo.config())

    case result do
      {:error, :already_up} -> :ok
      :ok -> :ok
    end
  end

  defp migrate_db do
    Ecto.Migrator.with_repo(Repo, &Ecto.Migrator.run(&1, :up, all: true))
  end
end

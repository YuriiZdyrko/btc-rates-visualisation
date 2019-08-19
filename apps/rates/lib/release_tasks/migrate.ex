defmodule Rates.ReleaseTasks do
  @moduledoc """
  Executed during `mix release`
  """

  def migrate() do
    Application.load(:rates_web)

    up()
    seed()
  end

  defp up do
    Ecto.Migrator.with_repo(Rates.Repo, &Ecto.Migrator.run(&1, :up, all: true))
  end

  defp seed do
    Code.eval_file Path.join([:code.priv_dir(Rates), "repo", "seeds.exs"])
  end
end

defmodule Rates.ReleaseTasks do
  @moduledoc """
  These tasks are run on CI server
  """

  def migrate() do
    Application.load(:rates_web)

    migrate()
    seed()
  end

  defp migrate do
    Ecto.Migrator.with_repo(Rates.Repo, &Ecto.Migrator.run(&1, :up, all: true))
  end

  defp seed do
    Code.eval_file Path.join([:code.priv_dir(Rates), "repo", "seeds.exs"])
  end
end

defmodule Rates.Scheduler do
  @moduledoc """
  Configured in config.exs, used for cron jobs.
  """

  use Quantum.Scheduler,
    otp_app: :rates
end

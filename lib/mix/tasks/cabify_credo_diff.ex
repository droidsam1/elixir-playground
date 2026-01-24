defmodule Mix.Tasks.CabifyCredoDiff do
  @moduledoc """
  Compatibility task used by pre-push hooks to run Credo.

  In this playground project it simply delegates to `mix credo --strict`.
  """

  use Mix.Task

  @shortdoc "Run Credo in strict mode (playground fallback implementation)"

  @impl Mix.Task
  def run(_args) do
    Mix.Task.run("credo", ["--strict"])
  end
end

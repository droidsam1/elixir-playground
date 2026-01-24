defmodule Ch5.Supervisor do
  @moduledoc """
  Top-level supervisor for chapter 5 examples.
  """

  use Supervisor

  def start_link(_arg) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    children = [
      {DatabaseServer, []},
      {Ch6.DatabaseGernserver, []}
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end
end

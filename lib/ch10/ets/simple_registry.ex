defmodule SimpleRegistry do
  @moduledoc "Simple registry to practice with ETS tables"
  use GenServer

  def init(init_arg) do
    {:ok, init_arg}
  end

  def start_link() do
    GenServer.start_link(__MODULE__, {})
  end

  def register(a_name) do
    :ok
  end
end

defmodule SimpleRegistry do
  @moduledoc "Simple registry to practice with ETS tables"
  use GenServer

  @table_name :simple_registry

  def init(init_arg) do
    {:ok, init_arg}
  end

  def start_link() do
    ets_table = :ets.new(@table_name, [:set, :named_table])
    GenServer.start_link(__MODULE__, ets_table)
  end

  @spec register(atom()) :: :ok
  def register(a_name) do
    case :ets.insert_new(@table_name, {a_name, 0}) do
      true -> :ok
      false -> :error
    end
  end
end

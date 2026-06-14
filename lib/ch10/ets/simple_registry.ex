defmodule SimpleRegistry do
  @moduledoc "Simple registry to practice with ETS tables"
  use GenServer

  @table_name :simple_registry

  @impl true
  def init(_) do
    :ets.new(@table_name, [:set, :named_table, :public])
    {:ok, nil}
  end

  def start_link do
    GenServer.start_link(__MODULE__, nil)
  end

  @spec register(atom()) :: :ok | :erro
  def register(a_name) do
    case :ets.insert_new(@table_name, {a_name, self()}) do
      true -> :ok
      false -> :error
    end
  end

  @spec whereis(atom()) :: pid() | nil
  def whereis(key) do
    case :ets.lookup(@table_name, key) do
      [{^key, pid}] -> pid
      [] -> nil
    end
  end
end

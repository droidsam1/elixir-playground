defmodule Ch6.DatabaseConnectionPool do
  @moduledoc """
  Connection pool for the database.
  """

  use GenServer

  def start_link(initial_state \\ %{}) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  @impl true
  def init(_opts \\ %{}) do
    {:ok, %{connections: 0}}
  end

  def connect() do
    case GenServer.call(__MODULE__, {:request_connection}) do
      {:ok, new_connection} -> IO.puts("Connected using #{new_connection}")
      {:error, _state} -> {:error, "no connections available"}
    end
  end

  def reset() do
    GenServer.cast(__MODULE__, :reset)
  end

  @impl true
  def handle_cast(:reset, state) do
    new_state = Map.put(state, :connections, 0)
    new_state = Map.put(new_state, :clients, %{})
    {:noreply, new_state}
  end

  @impl true
  def handle_call({:request_connection}, from, state) do
    n_connections = Map.get(state, :connections, 0)
    clients = Map.get(state, :clients, %{})
    client_connections = Map.get(clients, from, [])

    if n_connections < 3 do
      new_connection = n_connections + 1
      new_state = Map.put(state, :connections, new_connection)

      new_state =
        Map.put(
          new_state,
          :clients,
          Map.put(clients, from, [new_connection, client_connections])
        )

      {:reply, {:ok, new_connection}, new_state}
    else
      {:reply, {:error, "no connections available"}, state}
    end
  end
end

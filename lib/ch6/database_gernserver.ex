defmodule Ch6.DatabaseGernserver do
  @moduledoc """
  Simulates a simple key-value persistence server backed by a temporary file.
  """

  use GenServer

  @database_name "test"

  def start_link(initial_state) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def child_spec(_opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, []},
      restart: :permanent,
      shutdown: 5000,
      type: :worker
    }
  end

  @impl true
  def init(_initial_state \\ %{}) do
    filename = create_temp(@database_name)
    storage = load(filename)
    {:ok, {storage, filename}}
  end

  def storage(key, value) do
    GenServer.cast(__MODULE__, {:store, key, value})
  end

  def retrieve(key) do
    response = GenServer.call(__MODULE__, {:retrieve, key}, 1000)

    case response do
      {:ok, value} -> value
      _ -> {:error, "time out"}
    end
  end

  @impl true
  def handle_cast({:store, key, value}, {storage, filename}) do
    storage = Map.put(storage, key, value)
    binary = :erlang.term_to_binary(storage)
    File.write!(filename, binary)
    {:noreply, {storage, filename}}
  end

  @impl true
  def handle_call({:retrieve, :crash}, _from, _state) do
    raise "#{__MODULE__} has crashed"
  end

  @impl true
  def handle_call({:retrieve, key}, _from, {storage, filename}) do
    value = Map.get(storage, key, nil)
    {:reply, {:ok, value}, {storage, filename}}
  end

  defp create_temp(db_name) do
    tmp_dir = System.tmp_dir!()
    Path.join(tmp_dir, "db_#{db_name}")
  end

  defp load(filename) do
    # Check if file exists, return empty map if it doesn't
    case File.read(filename) do
      {:ok, binary} ->
        # Deserialize the binary back to a map
        :erlang.binary_to_term(binary)

      {:error, _} ->
        # File doesn't exist yet, start with empty map
        %{}
    end
  end
end

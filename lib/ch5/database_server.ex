defmodule DatabaseServer do
  @moduledoc """
    Simulate a persistence server
  """

  @database_name "test"
  def start() do
    spawn(fn -> init() end)
  end

  defp init() do
    filename = create_temp(@database_name)
    values = load(filename)
    loop(values, filename)
  end

  def storage(server_pid, key, value) do
    send(server_pid, {:store, key, value})
  end

  def retrieve(server_pid, key) do
    send(server_pid, {:retrieve, key, self()})

    receive do
      {:ok, value} -> value
      message -> {:error, message}
    after
      1000 -> {:error, "time out"}
    end
  end

  defp loop(storage, filename) do
    storage =
      receive do
        {:store, key, value} ->
          storage = Map.put(storage, key, value)
          # Serialize the map to binary format for storage
          binary = :erlang.term_to_binary(storage)
          File.write!(filename, binary)
          storage

        {:retrieve, key, caller_pid} ->
          send(caller_pid, {:ok, Map.get(storage, key, nil)})
          storage
      end

    loop(storage, filename)
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

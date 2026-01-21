defmodule DatabaseServer do
  @moduledoc """
    Simulate a persistence server
  """
  def start() do
    spawn(fn -> loop(%{}) end)
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

  defp loop(storage) do
    storage =
      receive do
        {:store, key, value} ->
          Map.put(storage, key, value)

        {:retrieve, key, caller_pid} ->
          send(caller_pid, {:ok, Map.get(storage, key, nil)})
          storage
      end

    loop(storage)
  end
end

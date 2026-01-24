defmodule CalculatorServer do
  @moduledoc """
  Server with state: an accumulator that holds the result of all requested operations.
  """

  def start do
    spawn(fn -> loop(0) end)
  end

  def add(server_pid, value) do
    send(server_pid, {:add, value})
  end

  def value(server_pid) do
    send(server_pid, {:value, self()})

    receive do
      {:response, value} ->
        value

      _ ->
        {:error, "Unexpected message received"}
    after
      3_000 ->
        {:error, "Processing the response timed out"}
    end
  end

  defp loop(current_value) do
    new_value =
      receive do
        {:add, value} ->
          current_value + value

        {:value, caller} ->
          send(caller, {:response, current_value})
          current_value
      end

    loop(new_value)
  end
end

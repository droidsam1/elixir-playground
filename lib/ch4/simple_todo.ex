defmodule SimpleTodo do
  @moduledoc """
    Simple Module to store and retrieve values, using simple raw functional approach (no agents, no genservers yet)
  """

  def new(initial_state \\ %{}) do
    initial_state
  end

  @spec add(map(), Date.t(), String.t()) :: map()
  def add(initial_state, day, todo_task) do
    Map.put(initial_state, day, todo_task)
  end

  @spec get(map(), Date.t()) :: String.t() | nil
  def get(initial_state, day) do
    Map.get(initial_state, day)
  end
end

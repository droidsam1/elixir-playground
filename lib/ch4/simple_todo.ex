defmodule SimpleTodo do
  @moduledoc """
    Simple Module to store and retrieve values, using simple raw functional approach (no agents, no genservers yet)
  """
  defstruct entries: %{}

  def new(initial_state \\ %{}) do
    %SimpleTodo{entries: initial_state}
  end

  @spec add(map(), Date.t(), String.t()) :: SimpleTodo
  def add(todo, day, new_task) do
    tasks_for_date = Map.get(todo.entries, day) || []
    tasks_for_date = [new_task | tasks_for_date]
    %SimpleTodo{entries: Map.put(todo.entries, day, tasks_for_date)}
  end

  @spec get(map(), Date.t()) :: map()
  def get(todo, day) do
    Map.get(todo.entries, day, [])
  end
end

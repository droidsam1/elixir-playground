defmodule SimpleTodo do
  @moduledoc """
    Simple Module to store and retrieve values, using simple raw functional approach (no agents, no genservers yet)
  """
  defstruct entries: %{}
  @type t :: %SimpleTodo{entries: %{}}

  def new(initial_state \\ %{}) do
    %SimpleTodo{entries: initial_state}
  end

  @spec add(SimpleTodo.t(), Date.t(), String.t()) :: SimpleTodo.t()
  def add(todo, day, new_task) do
    tasks_for_date = Map.get(todo.entries, day) || []
    tasks_for_date = [new_task | tasks_for_date]
    %SimpleTodo{entries: Map.put(todo.entries, day, tasks_for_date)}
  end

  @spec get(SimpleTodo.t(), Date.t()) :: list()
  def get(todo, day) do
    Map.get(todo.entries, day, [])
  end
end

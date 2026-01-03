defmodule SimpleTodo do
  @moduledoc """
    Simple Module to store and retrieve values, using simple raw functional approach (no agents, no genservers yet)
  """
  defstruct entries: %{}, next_id: 1
  @type t :: %SimpleTodo{entries: %{}}

  def new(initial_state \\ %{}) do
    Enum.reduce(
      initial_state,
      %SimpleTodo{},
      fn {date, tasks}, todo ->
        Enum.reduce(tasks, todo, fn task, acc ->
          SimpleTodo.add(acc, date, SimpleTodoEntry.new(acc.next_id + 1, task))
        end)
      end
    )
  end

  @spec add(SimpleTodo.t(), Date.t(), String.t()) :: SimpleTodo.t()
  def add(todo, day, new_task) do
    tasks_for_date = Map.get(todo.entries, day) || []
    tasks_for_date = [SimpleTodoEntry.new(todo.next_id, new_task) | tasks_for_date]
    %SimpleTodo{entries: Map.put(todo.entries, day, tasks_for_date), next_id: todo.next_id + 1}
  end

  @spec get(SimpleTodo.t(), Date.t()) :: list()
  def get(todo, day) do
    Map.get(todo.entries, day, [])
  end

  def update(todo, day, id, new_value) do
    updated_list = Map.get(todo.entries, day, [])
    |> Enum.map(fn %SimpleTodoEntry{} = entry ->
      if entry.id == id, do: %SimpleTodoEntry{entry | value: new_value}, else: entry
    end)

    updated_map = Map.put(todo.entries, day, updated_list)

    %SimpleTodo{entries: updated_map, next_id: todo.next_id}
  end
end

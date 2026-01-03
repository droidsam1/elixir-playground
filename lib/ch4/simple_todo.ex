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
    tasks_for_date = [SimpleTodoEntry.new(todo.next_id + 1, new_task) | tasks_for_date]
    %SimpleTodo{entries: Map.put(todo.entries, day, tasks_for_date)}
  end

  @spec get(SimpleTodo.t(), Date.t()) :: list()
  def get(todo, day) do
    Enum.map(Map.get(todo.entries, day, []), fn entry -> entry.value end)
  end

  # def update(todo, day, entry) do
  # end

end

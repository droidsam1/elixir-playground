defmodule SimpleTodo do
  @moduledoc """
    Simple Module to store and retrieve values, using simple raw functional approach (no agents, no genservers yet)
  """

  def new(initial_state \\ %{}) do
    initial_state
  end

  def add(initial_state, id, todo_task) do
    Map.put(initial_state, id, todo_task)
  end

  def get(initial_state, id) do
    Map.get(initial_state, id)
  end
end

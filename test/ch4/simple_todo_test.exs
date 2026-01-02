defmodule SimpleTodoTest do
  @moduledoc false
  use ExUnit.Case

  test "new returns an empty todo" do
    assert SimpleTodo.new() == %{}
  end

  test "add puts some value in the todo" do
    initial_state = SimpleTodo.new()
    state_after_first = SimpleTodo.add(initial_state, 1, "buy some bread")
    assert state_after_first == %{1 => "buy some bread"}

    assert SimpleTodo.add(state_after_first, 2, "buy some milk") == %{
             1 => "buy some bread",
             2 => "buy some milk"
           }
  end

  test "get returns and specific task from the todo" do
    initial_state = SimpleTodo.new(%{1 => "remember the milk"})

    assert SimpleTodo.get(initial_state, 1) == "remember the milk"
  end
end

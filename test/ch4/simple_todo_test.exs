defmodule SimpleTodoTest do
  @moduledoc false
  use ExUnit.Case

  test "new returns an empty todo" do
    assert SimpleTodo.new() == %{}
  end

  test "add puts some value in the todo" do
    day = Date.utc_today()
    another_day = Date.add(day, 1)
    initial_state = SimpleTodo.new()
    state_after_first = SimpleTodo.add(initial_state, day, "buy some bread")
    assert state_after_first == %{day => "buy some bread"}

    assert SimpleTodo.add(state_after_first, another_day, "buy some milk") == %{
             day => "buy some bread",
             another_day => "buy some milk"
           }
  end

  test "get returns and specific task from the todo" do
    day = Date.utc_today()
    initial_state = SimpleTodo.new(%{day => "remember the milk"})

    assert SimpleTodo.get(initial_state, day) == "remember the milk"
  end
end

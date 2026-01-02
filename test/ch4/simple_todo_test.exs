defmodule SimpleTodoTest do
  @moduledoc false
  use ExUnit.Case

  test "new returns an empty todo" do
    assert %SimpleTodo{entries: %{}} = SimpleTodo.new()
  end

  test "add puts some taks in the todo" do
    day = Date.utc_today()
    another_day = Date.add(day, 1)
    state_after_first = SimpleTodo.add(SimpleTodo.new(), day, "buy some bread")

    assert state_after_first == %SimpleTodo{entries: %{day => ["buy some bread"]}}

    assert SimpleTodo.add(state_after_first, another_day, "buy some milk") == %SimpleTodo{
             entries: %{
               day => ["buy some bread"],
               another_day => ["buy some milk"]
             }
           }
  end

  test "get returns and specific task from the todo" do
    day = Date.utc_today()
    todo = SimpleTodo.new(%{day => ["remember the milk"]})

    assert SimpleTodo.get(todo, day) == ["remember the milk"]
  end

  test "add can put n number of tasks in the same date" do
    day = Date.utc_today()
    todo = SimpleTodo.new()
    todo = SimpleTodo.add(todo, day, "remember the milk")
    todo = SimpleTodo.add(todo, day, "remember the vegetables")

    assert Enum.sort(SimpleTodo.get(todo, day)) ==
             Enum.sort(["remember the milk", "remember the vegetables"])
  end

  test "get returns empty when no task for specific day" do
    todo = SimpleTodo.new()
    day = Date.utc_today()

    assert SimpleTodo.get(todo, day) == []
  end
end

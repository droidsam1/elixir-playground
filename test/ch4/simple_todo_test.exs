defmodule SimpleTodoTest do
  @moduledoc false
  use ExUnit.Case

  test "new returns an empty todo" do
    assert %SimpleTodo{entries: %{}} = SimpleTodo.new()
  end

  test "add puts some taks in the todo" do
    day = Date.utc_today()
    another_day = Date.add(day, 1)
    todo = SimpleTodo.add(SimpleTodo.new(), day, "buy some bread")
    todo = SimpleTodo.add(todo, another_day, "buy some milk")

    assert [%SimpleTodoEntry{value: "buy some bread"}] = SimpleTodo.get(todo, day)
    assert [%SimpleTodoEntry{value: "buy some milk"}] = SimpleTodo.get(todo, another_day)
  end

  test "get returns and specific task from the todo" do
    day = Date.utc_today()
    todo = SimpleTodo.new()
    todo = SimpleTodo.add(todo, day, "remember the milk")

    assert [%SimpleTodoEntry{value: "remember the milk"}] = SimpleTodo.get(todo, day)
  end

  test "add can put n number of tasks in the same date" do
    day = Date.utc_today()
    todo = SimpleTodo.new()
    todo = SimpleTodo.add(todo, day, "remember the milk")
    todo = SimpleTodo.add(todo, day, "remember the vegetables")
    todo = SimpleTodo.add(todo, day, "remember the fruit")

    assert Enum.sort([
             %SimpleTodoEntry{id: 1, value: "remember the milk"},
             %SimpleTodoEntry{id: 2, value: "remember the vegetables"},
             %SimpleTodoEntry{id: 3, value: "remember the fruit"}
           ]) == Enum.sort(SimpleTodo.get(todo, day))
  end

  test "get returns empty when no task for specific day" do
    todo = SimpleTodo.new()
    day = Date.utc_today()

    assert [] = SimpleTodo.get(todo, day)
  end

  test "update an specific entry" do
    day = Date.utc_today()
    another_day = Date.add(day, 1)
    todo = SimpleTodo.new()
    todo = SimpleTodo.add(todo, another_day, "remember the flour")
    todo = SimpleTodo.add(todo, day, "remember the milk")
    todo = SimpleTodo.add(todo, day, "remember the vegetables")
    todo = SimpleTodo.add(todo, day, "remember the fruit")

    todo = SimpleTodo.update(todo, day, 4, "remember the eggs")

    expected_values = ["remember the milk", "remember the vegetables", "remember the eggs"]
    actual_values = Enum.map(SimpleTodo.get(todo, day), & &1.value)

    assert Enum.sort(expected_values) == Enum.sort(actual_values)
  end

  test "delete removes an specific entry" do
    day = Date.utc_today()
    another_day = Date.add(day, 1)
    todo = SimpleTodo.new()
    todo = SimpleTodo.add(todo, another_day, "remember the flour")
    todo = SimpleTodo.add(todo, day, "remember the milk")
    todo = SimpleTodo.add(todo, day, "remember the vegetables")
    todo = SimpleTodo.add(todo, day, "remember the fruit")

    todo = SimpleTodo.delete(todo, 4)

    expected_values = ["remember the milk", "remember the vegetables"]
    actual_values = Enum.map(SimpleTodo.get(todo, day), & &1.value)

    assert Enum.sort(expected_values) == Enum.sort(actual_values)
  end
end

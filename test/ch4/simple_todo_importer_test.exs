defmodule SimpleTodoImporterTest do
  @moduledoc false
  use ExUnit.Case

  test "import/2 returns a SimpleTodo" do
    todo = SimpleTodoImporter.import("../../blob/main/lib/ch4/todos.csv")

    assert todo == SimpleTodo.new()
  end
end

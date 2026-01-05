defmodule SimpleTodoImporterTest do
  @moduledoc false
  use ExUnit.Case

  test "import/2 returns a SimpleTodo" do
    todo = SimpleTodoImporter.import(Path.join([__DIR__, "../../lib/ch4/todos.csv"]))

    assert todo == %SimpleTodo{
             entries: %{
               "2018-12-19" => [
                 %SimpleTodoEntry{id: 3, value: "Movies"},
                 %SimpleTodoEntry{id: 1, value: "Dentist"}
               ],
               "2018-12-20" => [%SimpleTodoEntry{id: 2, value: "Shopping"}]
             },
             next_id: 4
           }
  end
end

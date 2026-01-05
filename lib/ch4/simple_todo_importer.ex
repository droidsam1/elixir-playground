defmodule SimpleTodoImporter do
  @moduledoc """
    Module to import from csv files the state of a SimpleTodo
  """

  def import(file_path) do
    case File.read(file_path) do
      {:ok, content} ->
        Enum.reduce(
          Enum.map(Enum.reject(String.split(content, "\n"), fn line -> line == "" end), fn line ->
            splitted = String.split(line, ",")
            {Enum.at(splitted, 0), Enum.at(splitted, 1)}
          end),
          %SimpleTodo{},
          fn {day, new_task}, todo ->
            SimpleTodo.add(todo, day, new_task)
          end
        )
    end
  end
end

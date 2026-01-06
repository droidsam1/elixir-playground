defmodule SimpleTodoImporter do
  @moduledoc """
    Module to import from csv files the state of a SimpleTodo
  """

  def import(file_path) do
    case File.read(file_path) do
      {:ok, content} ->
        content
        |> String.split("\n", trim: true)
        |> Enum.reduce(%SimpleTodo{}, fn line, todo ->
          {day, new_task} = split_line(line)
          SimpleTodo.add(todo, day, new_task)
        end)

      {:error, _reason} ->
        nil
    end
  end

  def split_line(line) do
    case String.split(line, ",", trim: true) do
      [day_string, task] ->
        {Date.from_iso8601!(day_string), task}

      _ ->
        nil
    end
  end
end

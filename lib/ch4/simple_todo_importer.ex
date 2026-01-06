defmodule SimpleTodoImporter do
  @moduledoc """
    Module to import from csv files the state of a SimpleTodo
  """

  def import(file_path) do
    case File.read(file_path) do
      {:ok, content} ->
        content
        |> String.split("\n", trim: true)
        |> Enum.map(&split_line/1)
        |> Enum.reduce(%SimpleTodo{}, fn {day, new_task}, todo ->
          SimpleTodo.add(todo, day, new_task)
        end)

      {:error, reason} ->
        raise reason
    end
  end

  def split_line(line) do
    case String.split(line, ",", trim: true) do
      [day_string, task] ->
        {Date.from_iso8601!(day_string), task}

      _ ->
        raise "Invalid CSV line #{line}"
    end
  end
end

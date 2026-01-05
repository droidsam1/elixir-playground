defmodule SimpleTodoImporter do
  @moduledoc """
    Module to import from csv files the state of a SimpleTodo
  """

  def import(file_path) do
    case File.read(file_path) do
      {:ok, content} ->
        content
        |> String.split("\n", trim: true)
        |> Enum.map(&parse_line/1)
        |> Enum.reduce(%SimpleTodo{}, fn {date, task}, todo ->
          SimpleTodo.add(todo, date, task)
        end)

      {:error, _reason} ->
        %SimpleTodo{}
    end
  end

  def parse_line(line) do
    case String.split(line, ",", trim: true) do
      [date_str, task] ->
        {:ok, date} = Date.from_iso8601(date_str)
        {date, task}

      _ ->
        raise "Invalid CSV line format: #{line}"
    end
  end
end

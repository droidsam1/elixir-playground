defmodule SimpleTodoImporter do
  @moduledoc """
    Module to import from csv files the state of a SimpleTodo
  """

  def import(file_path, todo \\ SimpleTodo.new()) do
    case File.read(file_path) do
      {:ok, content} ->
        SimpleTodo.new()

      # Enum.map(String.split(content, ","), )
      {:error, _reason} ->
        todo
    end
  end
end

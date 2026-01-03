defmodule SimpleTodoEntry do
  @moduledoc """
    Module to represent an entry within a SimpleTodo
  """
  defstruct id: Integer, value: String

  def new(id, value) do
    %SimpleTodoEntry{id: id, value: value}
  end
end

defmodule LargeLines do
  @moduledoc """
  Helpers for working with files and measuring or filtering line lengths.
  """

  def large_lines!(path) do
    File.stream!(path)
    |> Stream.map(&String.trim_trailing(&1, "\n"))
    |> Enum.filter(&(String.length(&1) > 80))
  end

  # Takes a file path and returns a list of numbers.
  # Each number represents the length of the corresponding line from the file.
  def large_lenghts(path) do
    File.stream!(path)
    |> Stream.map(&String.trim_trailing(&1, "\n"))
    |> Enum.map(&String.length/1)
  end

  def longest_line_lenght(path) do
    large_lenghts(path)
    # |> Enum.reduce(0, fn acc, element -> if element > acc, do: element, else: acc end)
    |> Enum.max()
  end
end

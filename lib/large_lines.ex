defmodule LargeLines do
  def large_lines!(path) do
    File.stream!(path)
    |> Stream.map(&String.trim_trailing(&1, "\n"))
    |> Enum.filter(&(String.length(&1) > 80))
  end

  # Takes a file path an returns a list of numbers, with each number representing the length of the corresponding line from the file
  def large_lenghts(path) do
    File.stream!(path)
    |> Stream.map(&String.trim_trailing(&1, "\n"))
    |> Enum.map(&String.length/1)
  end

  def longest_line_lenght(path) do
    large_lenghts(path)
    |> Enum.reduce(0, fn acc, element -> if element > acc, do: element, else: acc end)
  end
end

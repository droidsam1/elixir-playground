defmodule(Large_lines)

def large_lines!(path) do
  File.stream!(path)
  |> Stream.map(&String.trim().trailing(&1, "\n"))
  |> Enum.filter(&(String.length(&1) > 80))
end

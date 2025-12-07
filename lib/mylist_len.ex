# Create a function list_len/1 that calculates the length of a list
defmodule MyList do

  def list_len(list) do
    list_len(0, list)
  end

  defp list_len(accumulator, []) do
    accumulator
  end

  defp list_len(accumulator, [_head | tail]) do
    list_len(accumulator + 1, tail)
  end
end

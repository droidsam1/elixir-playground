# Create a function list_len/1 that calculates the length of a list
defmodule MyList do
  def list_len([]) do
    0
  end

  def list_len([_head | tail]) do
    list_len(1, tail)
  end

  defp list_len(accumulator, [_head | tail]) do
    accumulator + 1 + list_len(tail)
  end
end

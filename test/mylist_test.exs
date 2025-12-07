defmodule ListsTest do
  use ExUnit.Case

  test "list_len/1 returns 0 for empty list" do
    assert MyList.list_len([]) == 0
  end

  test "list_len/1 returns 1 for list with size 1" do
    assert MyList.list_len([1]) == 1
  end
end

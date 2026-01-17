defmodule CalculatorWithStateTest do
  use ExUnit.Case

  test "perfom sum two numbers" do
    pid = CalculatorServer.start()
    assert pid != nil && is_pid(pid)
  end
end

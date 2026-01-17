defmodule CalculatorWithStateTest do
  use ExUnit.Case

  test "start/0 starts a new proces" do
    pid = CalculatorServer.start()
    assert pid != nil && is_pid(pid)
  end

  test "add sums the number to server state" do
    pid = CalculatorServer.start()
    assert {:add, 10} = CalculatorServer.add(pid, 10)
  end
end

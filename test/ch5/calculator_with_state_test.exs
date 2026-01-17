defmodule CalculatorWithStateTest do
  use ExUnit.Case

  test "start/0 starts a new proces" do
    pid = CalculatorServer.start()
    assert pid != nil && is_pid(pid)
  end

  test "add sums the number to server accumulator" do
    pid = CalculatorServer.start()
    assert {:add, 10} = CalculatorServer.add(pid, 10)
  end

  test "start inits the internal accumulator to zero" do
    pid = CalculatorServer.start()
    assert 0 = CalculatorServer.value(pid)
  end
end

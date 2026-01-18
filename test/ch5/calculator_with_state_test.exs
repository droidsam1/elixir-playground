defmodule CalculatorWithStateTest do
  @moduledoc false
  use ExUnit.Case

  @number_of_concurrent_tasks 100_000

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

  test "value return current state of the accumulator" do
    pid = CalculatorServer.start()
    CalculatorServer.add(pid, 11)
    CalculatorServer.add(pid, 11)
    assert 22 = CalculatorServer.value(pid)
  end

  test "server supports concurrency" do
    pid = CalculatorServer.start()

    tasks =
      Enum.reduce(1..@number_of_concurrent_tasks, [], fn _x, tasks ->
        [Task.async(fn -> CalculatorServer.add(pid, 1) end) | tasks]
      end)

    # add sends a message, sending messages is fast, therefore does not wait for processing as processing is happening async in the loop function
    Task.await_many(tasks, 1_000)
    assert @number_of_concurrent_tasks = CalculatorServer.value(pid)
  end
end

defmodule CalculatorTest do
  use ExUnit.Case

  test "perfom sum two numbers" do
    {:result, result} = Calculator.process(:add, 1, 2)
    assert result == 3
  end
end

defmodule CalculatorTest do
  use ExUnit.Case

  test "can sum two numbers" do
    {:result, result} = Calculator.process(:add, 1, 2)
    assert result == 3
  end

  test "fail to sum if operands are not numbers" do
    {:error, reason} = Calculator.process(:add, 1, "")

    assert reason != nil
  end
end

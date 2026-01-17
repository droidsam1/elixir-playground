defmodule CalculatorTest do
  use ExUnit.Case

  test "perfom sum two numbers" do
    {:result, result} = Calculator.process(:add, 1, 2)
    assert result == 3
  end

  test "perfom substract two numbers" do
    {:result, result} = Calculator.process(:substract, 1, 2)
    assert result == -1
  end

  test "perfom multiplication of two numbers" do
    {:result, result} = Calculator.process(:multiplication, 10, 2)
    assert result == 20
  end

  test "perfom division of two numbers" do
    {:result, result} = Calculator.process(:division, 10, 2)
    assert result == 5
  end

  test "fail to sum if operands are not numbers" do
    {:error, reason} = Calculator.process(:add, 1, "")

    assert reason != nil
  end

  test "fail when unknown operator" do
    {:error, reason} = Calculator.process(:unknown, 1, 2)

    assert reason != nil
  end
end

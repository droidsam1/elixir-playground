defmodule Calculator do
  @moduledoc """
  Stateless calculator for performing basic arithmetic operations.
  """
  def process(op, operand1, operand2) do
    {operand1, operand2}
    |> validate_operands_are_numbers()
    |> perform_operation(op)
  end

  defp validate_operands_are_numbers({operand1, operand2} = _operands) do
    if is_number(operand1) && is_number(operand2) do
      {:ok, {operand1, operand2}}
    else
      {:error, "Operands must be numbers"}
    end
  end

  defp perform_operation({:ok, {operand1, operand2}}, :add) do
    {:result, operand1 + operand2}
  end

  defp perform_operation({:ok, {operand1, operand2}}, :substract) do
    {:result, operand1 - operand2}
  end

  defp perform_operation({:ok, {operand1, operand2}}, :multiplication) do
    {:result, operand1 * operand2}
  end

  defp perform_operation({:ok, {_operand1, 0}}, :division) do
    {:error, "Division by zero"}
  end

  defp perform_operation({:ok, {operand1, operand2}}, :division) do
    {:result, operand1 / operand2}
  end

  defp perform_operation({:ok, {_operand1, _operand2}}, _op) do
    {:error, "Unknown operator"}
  end

  defp perform_operation({:error, reason}, _op) do
    {:error, reason}
  end
end

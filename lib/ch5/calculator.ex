defmodule Calculator do
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

  defp perform_operation({:error, reason}, _op) do
    {:error, reason}
  end
end

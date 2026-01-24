defmodule DatabaseServerTest do
  @moduledoc false
  use ExUnit.Case

  test "starts DatabaseServer under supervision" do
    sup = start_supervised!(Ch5.Supervisor)

    children = Supervisor.which_children(sup)

    assert Enum.any?(children, fn
      {DatabaseServer, _pid, _type, _modules} -> true
      _ -> false
    end)
  end
end

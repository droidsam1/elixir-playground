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

  test "restart DatabaseServer when it crashses" do
    start_supervised!(Ch5.Supervisor)

    DatabaseServer.storage("a test key", "a value")
    assert "a value" = DatabaseServer.retrieve("a test key")

    old_pid = Process.whereis(DatabaseServer)

    # force a crash in the server
    DatabaseServer.retrieve(:crash)

    new_pid = Process.whereis(DatabaseServer)
    assert "a value" = DatabaseServer.retrieve("a test key")
    assert new_pid != old_pid
  end
end

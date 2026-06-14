defmodule SimpleRegistyTest do
  use ExUnit.Case

  test "start_link/0 starts a new process" do
    {:ok, pid} = SimpleRegistry.start_link()

    assert is_pid(pid)
    assert Process.alive?(pid)
  end

  test "register/1 accepts an atom" do
    assert :ok = SimpleRegistry.register(:some_name)
  end
end

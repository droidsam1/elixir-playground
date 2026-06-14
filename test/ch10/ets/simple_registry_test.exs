defmodule SimpleRegistyTest do
  use ExUnit.Case

  test "start_link/0 starts a new process" do
    {:ok, pid} = SimpleRegistry.start_link()

    assert is_pid(pid)
    assert Process.alive?(pid)
  end

  test "register/1 accepts an atom" do
    {:ok, _} = SimpleRegistry.start_link()

    assert :ok = SimpleRegistry.register(:some_name)
  end

  test "register/1 returns :error when inserting a duplicate" do
    {:ok, _} = SimpleRegistry.start_link()

    assert :ok = SimpleRegistry.register(:some_name)
    assert :error = SimpleRegistry.register(:some_name)
  end
end

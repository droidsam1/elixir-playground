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

  test "register/1 accepts different atoms" do
    SimpleRegistry.start_link()

    assert :ok = SimpleRegistry.register(:some_name)
    assert :ok = SimpleRegistry.register(:another_name)
  end

  test "whereis/1 accepts an atom" do
    SimpleRegistry.start_link()
    SimpleRegistry.register(:a_name)

    pid = SimpleRegistry.whereis(:a_name)

    assert is_pid(pid)
    assert Process.alive?(pid)
  end
end

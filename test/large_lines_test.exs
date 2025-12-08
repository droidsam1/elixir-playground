defmodule LargeLinesTest do
  use ExUnit.Case

  test "large_lenghts/1 returns line lengths" do
    path = create_temp_file()
    assert LargeLines.large_lenghts(path) == [5, 23, 79]
  end

  test "longest_line_length/1 returns the length of the longest line in a file" do
    path = create_temp_file()

    assert LargeLines.longest_line_lenght(path) == 79
  end

  defp create_temp_file() do
    path =
      System.tmp_dir!()
      |> Path.join("large_lines_test_#{System.unique_integer([:positive])}.txt")

    on_exit(fn -> File.rm(path) end)

    File.write!(
      path,
      "short\nthis line is exactly 23\nthis one is much longer than eighty characters so it should be counted properly\n"
    )

    path
  end
end

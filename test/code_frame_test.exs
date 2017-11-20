defmodule CodeFrameTest do
  use ExUnit.Case
  alias IO.ANSI

  test "prints before" do
    res = CodeFrame.build("foo\nbar\nbob", 1)
    assert res == "  1 | foo\n> 2 | bar\n    | ^^^\n  3 | bob"
  end

  test "respect line before and after" do
    res = CodeFrame.build("foo\nbar\nbob\nboof", 2, lines_after: 1, lines_before: 1)
    assert res == "  2 | bar\n> 3 | bob\n    | ^^^\n  4 | boof"
  end

  test "prints colors" do
    res = CodeFrame.build("foo\nbar\nbob\nboof", 1, colors: true)
    assert res =~ ANSI.red()
  end

  test "indent without colors" do
    res =
      CodeFrame.build(
        "foo\nbar\nbob\nboof\nfos\nasd\nasd\nasd\nasd\nasd\nasd\nasd",
        9
      )

    assert String.starts_with?(res, "  ")
  end

  test "indent with colors" do
    res =
      CodeFrame.build(
        "foo\nbar\nbob\nboof\nfos\nasd\nasd\nasd\nasd\nasd\nasd\nasd",
        9,
        colors: true
      )

    assert String.starts_with?(res, ANSI.light_black() <> "  ")
  end
end

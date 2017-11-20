defmodule CodeFrame do
  alias IO.ANSI

  @moduledoc """
  Documentation for CodeFrame.
  """

  @doc """
  Hello world.

  ## Examples

      iex> CodeFrame.hello
      :world

  """
  def hello do
    :world
  end

  @type options :: []

  @spec build(String.t(), integer, options) :: String.t()
  def build(input, line_pos, options \\ []) do
    lines = input |> String.split("\n")
    count = length(lines)

    # Parse Options
    showColors = Keyword.get(options, :colors, false)
    l_before = max(line_pos - Keyword.get(options, :lines_before, 2), 0)
    l_after = min(line_pos + Keyword.get(options, :lines_after, 2), count)

    lines
    |> Enum.with_index()
    |> Enum.filter(fn {_, i} -> i >= l_before and i <= l_after end)
    |> Enum.map(fn {x, i} -> print_column(x, i + 1, i == line_pos, showColors, count) end)
    |> Enum.join("\n")
  end

  defp print_column(content, line, active, showColors, total) do
    diff = length(Integer.digits(total, 10)) - length(Integer.digits(line, 10))
    indent = String.duplicate(" ", diff)

    if showColors do
      print_column_colors(content, line, active, indent)
    else
      print_column_raw(content, line, active, indent)
    end
  end

  defp print_column_colors(content, line, active, indent) do
    if active do
      # Code line
      prefix = ANSI.format([:bright, :red, "> ", indent, to_string(line), " | "])
      code = ANSI.format([:light_red_background, :black, " ", content, " ", ANSI.reset()])

      [prefix, code, ANSI.reset()]
    else
      prefix = ANSI.format([:light_black, "  ", indent, to_string(line), " |  "])
      ANSI.format([prefix, :default_color, content, ANSI.reset()])
    end
  end

  defp print_column_raw(content, line, active, indent) do
    if active do
      # Code line
      second_line = [" | ", String.duplicate("^", String.length(content))]
      indent2 = String.duplicate(" ", length(Integer.digits(line, 10)))
      ["> ", to_string(line), " | ", content, "\n  ", indent2, second_line]
    else
      ["  ", indent, to_string(line), " | ", content]
    end
  end
end
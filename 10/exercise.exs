defmodule Exercise do
  def parse_input() do
    File.read!("input2.txt")
    |> String.split("\n", trim: true)
  end

  def part1(lines)

  def part1(lines) do
    lines
    |> Enum.map(
      &(&1
        |> String.graphemes()
        |> find_illegal()
        |> score_char())
    )
    |> Enum.sum()
  end

  def part2(lines) do
    completions =
      lines
      |> Enum.map(fn line ->
        illegal =
          line
          |> String.graphemes()
          |> find_illegal()

        case is_list(illegal) do
          true -> complete_line(illegal)
          false -> []
        end
      end)
      |> List.flatten()
      |> Enum.sort()

    Enum.at(completions, completions |> length() |> div(2))
  end

  defp complete_line(open_chars) do
    open_chars
    |> Enum.reverse()
    |> Enum.reduce(0, fn char, acc ->
      score =
        case char do
          "[" -> 2
          "(" -> 1
          "{" -> 3
          "<" -> 4
        end

      acc * 5 + score
    end)
  end

  def find_illegal(line, open_chars \\ [])
  def find_illegal([], open_chars), do: open_chars
  def find_illegal(["[" | t], open_chars), do: find_illegal(t, open_chars ++ ["["])
  def find_illegal(["{" | t], open_chars), do: find_illegal(t, open_chars ++ ["{"])
  def find_illegal(["(" | t], open_chars), do: find_illegal(t, open_chars ++ ["("])
  def find_illegal(["<" | t], open_chars), do: find_illegal(t, open_chars ++ ["<"])

  def find_illegal([closing_char | t], open_chars) do
    case List.last(open_chars) == open_char(closing_char) do
      true -> find_illegal(t, Enum.drop(open_chars, -1))
      false -> closing_char
    end
  end

  defp open_char("]"), do: "["
  defp open_char("}"), do: "{"
  defp open_char(")"), do: "("
  defp open_char(">"), do: "<"

  defp score_char("]"), do: 57
  defp score_char("}"), do: 1197
  defp score_char(")"), do: 3
  defp score_char(">"), do: 25137
  defp score_char(_), do: 0
end

Exercise.parse_input()
|> Exercise.part2()
|> IO.inspect()

# Exercise.parse_input()
# |> Exercise.part1()
# |> IO.inspect()

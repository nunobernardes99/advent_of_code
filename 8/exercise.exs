defmodule Exercise do
  def parse_input() do
    File.read!("input.txt")
    |> String.split("\n")
    |> Enum.map(&String.split(&1, "|", trim: true))
  end

  # Number 1 has 2 segments on
  # Number 4 has 4 segments on
  # Number 7 has 3 segments on
  # Number 8 has 7 segments on

  def find_digits(signals, count \\ 0)
  def find_digits([], count), do: count

  def find_digits([[_, output] | t], count) do
    line_count =
      output
      |> String.split(" ", trim: true)
      |> Enum.filter(&(String.length(&1) in [2, 3, 4, 7]))
      |> length()

    find_digits(t, count + line_count)
  end
end

# ^[^<>]*$

Exercise.parse_input()
|> Exercise.find_digits()
|> IO.inspect()

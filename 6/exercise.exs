defmodule Exercise do
  def parse_input() do
    File.read!("input.txt")
    |> String.split(",")
    |> Enum.map(&String.to_integer(&1))
  end

  def count_lanternfishes(fishes, day \\ 0)
  def count_lanternfishes(fishes, 80), do: length(fishes)

  def count_lanternfishes(fishes, day) do
    count_new_fishes = Enum.filter(fishes, &(&1 == 0)) |> length()

    fishes
    |> Enum.map(&if &1 == 0, do: 6, else: &1 - 1)
    |> List.flatten(List.duplicate(8, count_new_fishes))
    |> count_lanternfishes(day + 1)
  end
end

Exercise.parse_input()
|> Exercise.count_lanternfishes()
|> IO.inspect()

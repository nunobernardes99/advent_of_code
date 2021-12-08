defmodule Exercise do
  def parse_input() do
    File.read!("input.txt")
    |> String.split(",")
    |> Enum.map(&String.to_integer(&1))
    |> Enum.group_by(& &1)
    |> Enum.reduce(List.duplicate(0, 9), fn {age, fishes_with_age}, acc ->
      acc
      |> List.delete_at(age)
      |> List.insert_at(age, length(fishes_with_age))
    end)
  end

  def linear_lanternfish_count(fishes, day \\ 0)

  def linear_lanternfish_count(fishes, 256), do: Enum.sum(fishes)

  def linear_lanternfish_count([n0, n1, n2, n3, n4, n5, n6, n7, n8], day) do
    linear_lanternfish_count([n1, n2, n3, n4, n5, n6, n7 + n0, n8, n0], day + 1)
  end
end

Exercise.parse_input()
|> Exercise.linear_lanternfish_count()
|> IO.inspect()

defmodule Exercise do
  def parse_input() do
    File.read!("input.txt")
    |> String.split(",")
    |> Enum.map(&String.to_integer(&1))
  end

  def fuel_spend(crabs, checked_paths \\ [], fuel_spent \\ [])

  def fuel_spend([], _, fuel_spent) do
    fuel_spent
    |> Enum.sort()
    |> List.first()
  end

  def fuel_spend([crab | crabs], checked_paths, fuel_spent) do
    fuel =
      (crabs ++ checked_paths)
      |> Enum.map(&abs(&1 - crab))
      |> Enum.sum()

    fuel_spend(crabs, checked_paths ++ [crab], fuel_spent ++ [fuel])
  end
end

Exercise.parse_input()
|> Exercise.fuel_spend()
|> IO.inspect()

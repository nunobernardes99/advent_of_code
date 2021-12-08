defmodule Exercise do
  def parse_input() do
    File.read!("input.txt")
    |> String.split(",")
    |> Enum.map(&String.to_integer(&1))
  end

  def possible_paths(crabs) do
    lower_crab = Enum.min(crabs)
    higher_crab = Enum.max(crabs)
    Enum.to_list(lower_crab..higher_crab)
  end

  def fuel_spend(paths, crabs, fuel_spent \\ [])

  def fuel_spend([], _, fuel_spent),
    do:
      fuel_spent
      |> Enum.sort()
      |> List.first()

  def fuel_spend([path | paths], crabs, fuel_spent) do
    fuel =
      crabs
      |> Enum.map(fn crab ->
        case crab == path do
          true ->
            0

          false ->
            1..abs(crab - path)
            |> Enum.sum()
        end
      end)
      |> Enum.sum()

    fuel_spend(paths, crabs, fuel_spent ++ [fuel])
  end
end

crabs = Exercise.parse_input()
paths = Exercise.possible_paths(crabs)

Exercise.fuel_spend(paths, crabs)
|> IO.inspect()

defmodule Exercise do
  def parse_input() do
    File.read!("input.txt")
    |> String.split("\n")
    |> Enum.map(&String.to_integer(&1))
  end

  def find_increase([], increase), do: increase
  def find_increase([_], increase), do: find_increase([], increase)
  def find_increase([head1, head2 | tail], increase) when head2 > head1, do: find_increase([head2 | tail], increase + 1)
  def find_increase([_, head2 | tail], increase), do: find_increase([head2 | tail], increase)

  def group_three_numbers([], grouped_list), do: grouped_list
  def group_three_numbers([_, _], grouped_list), do: group_three_numbers([], grouped_list)
  def group_three_numbers([head1, head2, head3 | tail], grouped_list),
    do: group_three_numbers([head2, head3 | tail], grouped_list ++ [head1 + head2 + head3])
end

Exercise.parse_input()
|> Exercise.find_increase(0)
|> IO.inspect()

Exercise.parse_input()
|> Exercise.group_three_numbers([])
|> Exercise.find_increase(0)
|> IO.inspect()

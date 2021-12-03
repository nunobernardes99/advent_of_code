defmodule Exercise do
  def parse_input() do
    File.read!("input.txt")
    |> String.split("\n")
    |> Enum.map(fn movement ->
      [move, amount] = String.split(movement)
      [move, String.to_integer(amount)]
    end)
  end

  def find_position([], h_position, depth), do: h_position * depth
  def find_position([["forward", amount] | t], h_position, depth), do: find_position(t, h_position + amount, depth)
  def find_position([["down", amount] | t], h_position, depth), do: find_position(t, h_position, depth + amount)
  def find_position([["up", amount] | t], h_position, depth), do: find_position(t, h_position, depth - amount)

  def find_position_and_aim([], h_position, depth, _), do: h_position * depth
  def find_position_and_aim([["forward", amount] | t], h_position, depth, 0), do: find_position_and_aim(t, h_position + amount, depth, 0)
  def find_position_and_aim([["forward", amount] | t], h_position, depth, aim), do: find_position_and_aim(t, h_position + amount, depth + (aim * amount), aim)
  def find_position_and_aim([["down", amount] | t], h_position, depth, aim), do: find_position_and_aim(t, h_position, depth, aim + amount)
  def find_position_and_aim([["up", amount] | t], h_position, depth, aim), do: find_position_and_aim(t, h_position, depth, aim - amount)
end

Exercise.parse_input()
|> Exercise.find_position(0, 0)
|> IO.inspect()

Exercise.parse_input()
|> Exercise.find_position_and_aim(0, 0, 0)
|> IO.inspect()

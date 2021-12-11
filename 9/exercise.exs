defmodule Exercise do
  def parse_input() do
    File.read!("input.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
    end)
  end

  def grid(lists \\ []) do
    lists
    |> Enum.with_index()
    |> Enum.map(fn {row_list, y_coord} -> row(row_list, y_coord) end)
  end

  def row(row_list, row_index) do
    row_list
    |> Enum.with_index()
    |> Enum.map(fn {value, x_coord} -> {value, x_coord, row_index} end)
  end

  def part1(grid) do
    grid
    |> List.flatten()
    |> Enum.map(fn {value, x, y} ->
      neighbours(x, y)
      |> Enum.reject(fn {x, y} -> x < 0 || y < 0 end)
      |> Enum.map(fn {adjacent_x, adjacent_y} ->
        Enum.at(grid, adjacent_y, [])
        |> Enum.at(adjacent_x, {10, 0, 0})
        |> Tuple.to_list()
        |> List.first()
      end)
      |> Enum.min()
      |> Kernel.>(value)
      |> lowest_point?(value)
    end)
    |> Enum.sum()
  end

  defp lowest_point?(true, value), do: value + 1
  defp lowest_point?(_, _), do: 0

  defp neighbours(x_coord, y_coord),
    do: [
      {x_coord - 1, y_coord},
      {x_coord, y_coord - 1},
      {x_coord + 1, y_coord},
      {x_coord, y_coord + 1}
    ]
end

Exercise.parse_input()
|> Exercise.grid()
|> Exercise.part1()
|> IO.inspect()

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
    |> List.flatten()
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

  def part2(grid) do
    {last_group, basins} =
      find_low_points(grid)
      |> Enum.reduce({grid, []}, fn low_point, {non_visited, basins} ->
        basin =
          find_basin(non_visited, low_point)
          |> List.flatten()
          |> Enum.uniq()

        {non_visited -- basin, basins ++ [basin]}
      end)

    (basins ++ [last_group])
    |> Enum.map(fn basin ->
      basin
      |> Enum.reject(fn {v, _, _} -> v == 9 end)
      |> Enum.count()
    end)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  defp find_basin(grid, curr, basin \\ [])
  defp find_basin(_grid, {9, x, y}, basin), do: basin ++ [{9, x, y}]

  defp find_basin(grid, {_v, x, y}, basin) do
    adjacents = adjacents(grid, x, y)

    adjacents
    |> Enum.map(&find_basin(grid -- [&1], &1, basin ++ [&1]))
  end

  defp find_low_points(grid) do
    grid
    |> Enum.reduce([], fn {v, x, y}, low_points ->
      {adj_v, _adj_x, _adj_y} =
        adjacents(grid, x, y)
        |> Enum.min_by(fn {v, _, _} -> v end, fn -> {10, 10, 10} end)

      case adj_v > v do
        true -> low_points ++ [{v, x, y}]
        false -> low_points
      end
    end)
  end

  defp adjacents(grid, x1, y1) do
    neighbours = neighbours(x1, y1)

    grid
    |> Enum.filter(fn {_, x2, y2} -> {x2, y2} in neighbours end)
  end

  defp neighbours(x, y), do: [{x, y + 1}, {x, y - 1}, {x + 1, y}, {x - 1, y}]
end

# Exercise.parse_input()
# |> Exercise.grid()
# |> Exercise.part1()
# |> IO.inspect()

Exercise.parse_input()
|> Exercise.grid()
|> Exercise.part2()
|> IO.inspect()

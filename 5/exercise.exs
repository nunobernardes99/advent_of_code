defmodule Exercise do
  def parse_input() do
    File.read!("input.txt")
    |> String.split("\n")
    |> Enum.map(&(&1 |> String.replace(" ", "") |> String.split("->")))
  end

  def count_hydrothermal_vents(coordinates) do
    coordinates_map =
      coordinates
      |> Enum.reduce([], fn [initial, final], acc ->
        [x1, y1] = String.split(initial, ",") |> Enum.map(&String.to_integer(&1))
        [x2, y2] = String.split(final, ",") |> Enum.map(&String.to_integer(&1))

        acc ++ draw_hydrothermal_line(x1, x2, y1, y2)
      end)

    # to get a unique list of duplicates
    Enum.uniq(coordinates_map -- Enum.uniq(coordinates_map))
    |> length()
  end

  # Line is a point
  def draw_hydrothermal_line(x, x, y, y), do: [{x, y}]
  # Line is vertical
  def draw_hydrothermal_line(x, x, y1, y2) do
    y_interval = Enum.to_list(y1..y2)
    x_interval = List.duplicate(x, length(y_interval))
    Enum.zip(x_interval, y_interval)
  end

  # Line is horizontal
  def draw_hydrothermal_line(x1, x2, y, y) do
    x_interval = Enum.to_list(x1..x2)
    y_interval = List.duplicate(y, length(x_interval))
    Enum.zip(x_interval, y_interval)
  end

  # Line is diagonal
  def draw_hydrothermal_line(x1, x2, y1, y2) do
    x_interval = Enum.to_list(x1..x2)
    y_interval = Enum.to_list(y1..y2)
    Enum.zip(x_interval, y_interval)
  end
end

Exercise.parse_input()
|> Exercise.count_hydrothermal_vents()
|> IO.inspect()

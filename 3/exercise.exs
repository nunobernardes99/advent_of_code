defmodule Exercise do
  def parse_input() do
    File.read!("input.txt")
    |> String.split("\n")
  end

  def gama_rate_and_epsilon([]), do: 0

  def gama_rate_and_epsilon(binaries_list) do
    binaries_list
    |> Enum.map(&String.graphemes(&1))
    |> Enum.zip()
    |> Enum.reduce(["", ""], fn binary, [gama_rate, epsilon] ->
      binary_list = Tuple.to_list(binary)
      count_zeros = Enum.count(binary_list, &(&1 == "0"))
      count_ones = length(binary_list) - count_zeros

      case count_zeros > count_ones do
        true -> [gama_rate <> "0", epsilon <> "1"]
        false -> [gama_rate <> "1", epsilon <> "0"]
      end
    end)
    |> Enum.map(&(String.to_integer(&1) |> Integer.digits() |> Integer.undigits(2)))
    |> Enum.product()
  end

  def o2_and_co2_readings(binaries_list),
    do: gas_ratings(binaries_list, :co2) * gas_ratings(binaries_list, :o2)

  def gas_ratings(binaries_list, reader, position \\ 0)

  def gas_ratings([binaries_list], _, _),
    do: String.to_integer(binaries_list) |> Integer.digits() |> Integer.undigits(2)

  def gas_ratings(binaries_list, reader, position) do
    consider_numbers_list =
      binaries_list
      |> Enum.map(&String.graphemes(&1))
      |> Enum.zip()
      |> Enum.at(position)
      |> Tuple.to_list()

    count_zeros = Enum.count(consider_numbers_list, &(&1 == "0"))
    count_ones = length(consider_numbers_list) - count_zeros

    {most_common_value, less_common_value} =
      case count_ones >= count_zeros do
        true -> {"1", "0"}
        false -> {"0", "1"}
      end

    common_value =
      case reader do
        :co2 -> most_common_value
        :o2 -> less_common_value
      end

    common_binaries = Enum.filter(binaries_list, &(String.at(&1, position) == common_value))

    gas_ratings(common_binaries, reader, position + 1)
  end
end

Exercise.parse_input()
|> Exercise.gama_rate_and_epsilon()
|> IO.inspect(label: :part1)

Exercise.parse_input()
|> Exercise.o2_and_co2_readings()
|> IO.inspect(label: :part2)

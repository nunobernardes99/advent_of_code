defmodule Exercise do
  def parse_input() do
    File.read!("input.txt")
    |> String.split("\n")
    |> Enum.map(&String.split(&1, "|", trim: true))
  end

  def find_digits(signals, count \\ 0)
  def find_digits([], count), do: count

  def find_digits([[decoder, output] | t], count) do
    decoder =
      decoder
      |> String.split(" ", trim: true)

    num1 = Enum.find(decoder, &(String.length(&1) == 2))
    num4 = Enum.find(decoder, &(String.length(&1) == 4))

    num3 =
      decoder
      |> Enum.filter(&(String.length(&1) == 5))
      |> Enum.find(fn size5 ->
        size5
        |> String.split("", trim: true)
        |> Kernel.--(String.split(num1, "", trim: true))
        |> length()
        |> Kernel.==(3)
      end)
      |> String.split("", trim: true)

    num2 =
      decoder
      |> Enum.filter(&(String.length(&1) == 5))
      |> Enum.find(fn size5 ->
        size5
        |> String.split("", trim: true)
        |> Kernel.--(String.split(num4, "", trim: true))
        |> length()
        |> Kernel.==(3)
      end)
      |> String.split("", trim: true)

    num5 =
      decoder
      |> Enum.find(
        &(String.length(&1) == 5 and &1 not in [num3 |> Enum.join(), num2 |> Enum.join()])
      )
      |> String.split("", trim: true)

    num0 =
      decoder
      |> Enum.filter(&(String.length(&1) == 6))
      |> Enum.find(fn size5 ->
        size5
        |> String.split("", trim: true)
        |> Kernel.--(num5)
        |> length()
        |> Kernel.==(2)
      end)
      |> String.split("", trim: true)

    num9 =
      decoder
      |> Enum.filter(&(String.length(&1) == 6))
      |> Enum.find(fn size5 ->
        size5
        |> String.split("", trim: true)
        |> Kernel.--(num3)
        |> length()
        |> Kernel.==(1)
      end)
      |> String.split("", trim: true)

    [n1, n2, n3, n4] =
      output
      |> String.split(" ", trim: true)
      |> Enum.map(fn out ->
        split_out = out |> String.split("", trim: true)

        cond do
          String.length(out) == 2 -> 1
          String.length(out) == 4 -> 4
          String.length(out) == 3 -> 7
          String.length(out) == 7 -> 8
          split_out -- num3 == [] -> 3
          split_out -- num2 == [] -> 2
          split_out -- num5 == [] -> 5
          split_out -- num0 == [] -> 0
          split_out -- num9 == [] -> 9
          true -> 6
        end
      end)

    curr_count = n1 * 1000 + n2 * 100 + n3 * 10 + n4 * 1
    find_digits(t, count + curr_count)
  end
end

# ^[^<>]*$

Exercise.parse_input()
|> Exercise.find_digits()
|> IO.inspect()

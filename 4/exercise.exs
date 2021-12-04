defmodule Exercise do
  def parse_input() do
    [drawn_numbers, _ | boards] =
      File.read!("input.txt")
      |> String.split("\n")

    boards =
      boards
      |> Enum.map(&String.split(&1))
      |> Enum.chunk_every(6)
      |> Enum.map(&List.flatten(&1))

    {drawn_numbers |> String.split(","), boards}
  end

  def bingo({drawn_numbers, boards}, _) when drawn_numbers == [] or boards == [],
    do: IO.puts("Game ended :D")

  def bingo({[n1, n2, n3, n4, n5 | drawn_numbers], boards}, []) do
    past_numbers = [n1, n2, n3, n4, n5]

    playing_boards =
      boards
      |> Enum.map(fn board ->
        case won?(winning_combinations(board), past_numbers) do
          true -> winner(board, past_numbers)
          false -> board
        end
      end)
      |> Enum.reject(&is_nil(&1))

    bingo({drawn_numbers, playing_boards}, [n1, n2, n3, n4, n5])
  end

  def bingo({[curr_number | drawn_numbers], boards}, past_numbers) do
    past_numbers = past_numbers ++ [curr_number]

    playing_boards =
      boards
      |> Enum.map(fn board ->
        case won?(winning_combinations(board), past_numbers) do
          true -> winner(board, past_numbers)
          false -> board
        end
      end)
      |> Enum.reject(&is_nil(&1))

    bingo({drawn_numbers, playing_boards}, past_numbers)
  end

  def winner(board, past_numbers) do
    (((board -- past_numbers)
      |> Enum.map(&String.to_integer(&1))
      |> Enum.sum()) * String.to_integer(List.last(past_numbers)))
    |> IO.inspect()

    nil
  end

  def winning_combinations(board) do
    winning_rows = Enum.chunk_every(board, 5)
    winning_collumns = winning_rows |> Enum.zip() |> Enum.map(&Tuple.to_list(&1))
    winning_rows ++ winning_collumns
  end

  def won?(win_combinations, drawn_numbers) do
    combination =
      win_combinations
      |> Enum.find(&(&1 -- drawn_numbers == []))

    case combination do
      nil -> false
      _ -> true
    end
  end
end

Exercise.parse_input()
|> Exercise.bingo([])

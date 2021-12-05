defmodule Day4.Part1 do
  def run() do
    # "lib/day4_data_test.txt"
    # "lib/day4_data.txt"
    [numbers | boards] =
      "lib/day4_data.txt"
      |> File.read!()
      |> String.split("\n", trim: true)

    numbers = String.split(numbers, ",") |> Enum.map(&String.to_integer/1)

    boards = prepare_boards(boards)

    numbers
    |> Enum.with_index()
    |> Enum.reduce_while({:error, nil}, fn {_x, number_index}, _ ->
      list_piece = Enum.take(numbers, number_index + 4)

      Enum.reduce_while(boards, {:error, nil}, fn board, _ ->
        search_by_rows(board, list_piece)
        |> case do
          {:ok, board} ->
            {:ok, board}

          {:error, nil} ->
            search_by_columns(board, list_piece)
        end
        |> case do
          {:ok, board} -> {:halt, {:ok, board}}
          {:error, nil} -> {:cont, {:error, nil}}
        end
      end)
      |> case do
        {:ok, board} -> {:halt, {:ok, {board, list_piece}}}
        {:error, nil} -> {:cont, {:error, nil}}
      end
    end)
    |> calculate_result()
  end

  defp search_by_rows(board, list_piece) do
    Enum.reduce_while(board, {:error, nil}, fn row, _acc ->
      value =
        Enum.map(row, fn value ->
          Enum.member?(list_piece, value)
        end)

      case Enum.all?(value) do
        false -> {:cont, {:error, nil}}
        true -> {:halt, {:ok, board}}
      end
    end)
  end

  defp search_by_columns(board, list_piece) do
    result_column =
      Enum.map(0..4, fn index ->
        Enum.map(board, fn column -> Enum.at(column, index) end)
      end)
      |> Enum.map(fn column ->
        Enum.map(column, fn value ->
          Enum.member?(list_piece, value)
        end)
        |> Enum.all?()
      end)

    case Enum.any?(result_column) do
      false -> {:error, nil}
      true -> {:ok, board}
    end
  end

  defp prepare_boards(boards) do
    Enum.chunk_every(boards, 5)
    |> Enum.map(fn board ->
      Enum.map(board, fn row ->
        String.split(row, " ", trim: true)
        |> Enum.map(fn x -> String.to_integer(x, 10) end)
      end)
    end)
  end

  defp calculate_result({:ok, {board, list}}) do
    result =
      Enum.reduce(board, 0, fn row, acc ->
        Enum.reduce(row, acc, fn value, row_acc ->
          if Enum.member?(list, value) do
            row_acc
          else
            row_acc + value
          end
        end)
      end)

    result * List.last(list)
  end

  defp calculate_result({:error, val}), do: {:error, val}
end

defmodule Day5.Part1 do
  def run() do
    list =
      "lib/day5_data.txt"
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.map(fn x -> String.split(x, " -> ", trim: true) end)
      |> Enum.map(fn x ->
        Enum.map(x, fn y ->
          [val1, val2] = String.split(y, ",", trim: true)

          {String.to_integer(val1), String.to_integer(val2)}
        end)
        |> filter_list()
      end)
      |> Enum.filter(fn x -> !is_nil(x) end)

    initial_array = Enum.map(0..1000, fn _x -> Enum.map(0..1000, fn _x -> 0 end) end)

    Enum.reduce(list, initial_array, fn [{x1, y1}, {x2, y2}], acc ->
      if x1 == x2 do
        Enum.reduce(y1..y2, acc, fn x, acc_map ->
          {_, arr} = get_and_update_in(acc_map, [Access.at(x), Access.at(x1)], &{&1, &1 + 1})

          arr
        end)
      else
        Enum.reduce(x1..x2, acc, fn x, acc_map ->
          {_, arr} = get_and_update_in(acc_map, [Access.at(y1), Access.at(x)], &{&1, &1 + 1})

          arr
        end)
      end
    end)
    |> calculate_result()
  end

  defp filter_list([{x1, y1}, {x2, y2}]) do
    if x1 == x2 or y2 == y1 do
      [{x1, y1}, {x2, y2}]
    else
      nil
    end
  end

  defp calculate_result(array) do
    Enum.map(
      array,
      fn x ->
        Enum.count(x, fn y -> y >= 2 end)
      end
    )
    |> Enum.sum()
  end
end

defmodule Day5.Part2 do
  def run() do
    list =
      "lib/day5_data.txt"
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.map(fn x -> String.split(x, " -> ", trim: true) end)
      |> Enum.map(fn x ->
        Enum.map(x, fn y ->
          [val1, val2] = String.split(y, ",", trim: true)

          {String.to_integer(val1), String.to_integer(val2)}
        end)
      end)
      |> Enum.filter(fn x -> !is_nil(x) end)

    initial_array = Enum.map(0..1000, fn _x -> Enum.map(0..1000, fn _x -> 0 end) end)
    # initial_array = Enum.map(0..9, fn _x -> Enum.map(0..9, fn _x -> 0 end) end)

    Enum.reduce(list, initial_array, fn [{x1, y1}, {x2, y2}], acc ->
      cond do
        x1 == x2 ->
          Enum.reduce(y1..y2, acc, fn x, acc_map ->
            {_, arr} = get_and_update_in(acc_map, [Access.at(x), Access.at(x1)], &{&1, &1 + 1})

            arr
          end)

        y1 == y2 ->
          Enum.reduce(x1..x2, acc, fn x, acc_map ->
            {_, arr} = get_and_update_in(acc_map, [Access.at(y1), Access.at(x)], &{&1, &1 + 1})

            arr
          end)

        true ->
          x = Enum.map(x1..x2, fn x -> x end)
          y = Enum.map(y1..y2, fn y -> y end)

          Enum.reduce(0..(length(x) - 1), acc, fn index, acc_map ->
            {_, arr} =
              get_and_update_in(
                acc_map,
                [Access.at(Enum.at(y, index)), Access.at(Enum.at(x, index))],
                &{&1, &1 + 1}
              )

            arr
          end)
      end
    end)
    |> calculate_result()
  end

  defp calculate_result(array) do
    Enum.map(
      array,
      fn x ->
        Enum.count(x, fn y -> y >= 2 end)
      end
    )
    |> Enum.sum()
  end
end

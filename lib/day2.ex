defmodule Day2.Part1 do
  def run() do
    list = "lib/day2_data.txt" |> File.read!() |> String.trim() |> String.split("\n")
    #  list =  ["forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"]
    basic_list = %{horizontal: 0, depth: 0}

    list =
      list
      |> Enum.map(fn x ->
        [command, value] = String.split(x, " ")

        {command, value}
      end)

    map =
      Enum.reduce(list, basic_list, fn {command, value}, acc ->
        value = String.to_integer(value)

        case command do
          "forward" -> Map.replace(acc, :horizontal, Map.get(acc, :horizontal) + value)
          "down" -> Map.replace(acc, :depth, Map.get(acc, :depth) + value)
          "up" -> Map.replace(acc, :depth, Map.get(acc, :depth) - value)
        end
      end)

    map.horizontal * map.depth
  end
end

defmodule Day2.Part2 do
  def run() do
    list = "lib/day2_data.txt" |> File.read!() |> String.trim() |> String.split("\n")
    # list = ["forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"]
    basic_list = %{horizontal: 0, depth: 0, aim: 0}

    list =
      list
      |> Enum.map(fn x ->
        [command, value] = String.split(x, " ")

        {command, value}
      end)

    map =
      Enum.reduce(list, basic_list, fn {command, value}, acc ->
        value = String.to_integer(value)

        case command do
          "forward" ->
            map = Map.replace(acc, :horizontal, Map.get(acc, :horizontal) + value)
            Map.replace(map, :depth, Map.get(acc, :depth) + Map.get(acc, :aim) * value)

          "down" ->
            Map.replace(acc, :aim, Map.get(acc, :aim) + value)

          "up" ->
            Map.replace(acc, :aim, Map.get(acc, :aim) - value)
        end
      end)

    map.horizontal * map.depth
  end
end

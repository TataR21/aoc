defmodule Day3.Part1 do
  def run() do
    list = "lib/day3_data.txt" |> File.read!() |> String.trim() |> String.split("\n")

    # list = [
    #   "00100",
    #   "11110",
    #   "10110",
    #   "10111",
    #   "10101",
    #   "01111",
    #   "00111",
    #   "11100",
    #   "10000",
    #   "11001",
    #   "00010",
    #   "01010"
    # ]

    list =
      Enum.map(list, fn x ->
        String.split(x, "", trim: true)
      end)

    number =
      Enum.map(0..(length(List.first(list)) - 1), fn index ->
        return_list =
          Enum.reduce(list, %{zero: 0, one: 0}, fn x, acc ->
            if Enum.at(x, index) == "1" do
              Map.replace(acc, :one, acc.one + 1)
            else
              Map.replace(acc, :zero, acc.zero + 1)
            end
          end)

        if return_list.one > return_list.zero do
          1
        else
          0
        end
      end)

    {gamma, ""} = number |> Enum.join() |> Integer.parse(2)

    {epsilon, ""} =
      Enum.map(number, fn x ->
        if x == 1 do
          0
        else
          1
        end
      end)
      |> Enum.join()
      |> Integer.parse(2)

    gamma * epsilon
  end
end

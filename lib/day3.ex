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

defmodule Day3.Part2 do
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

    {generator_rating, ""} =
      calculate_generator_rating(list, 0) |> Enum.join() |> Integer.parse(2) |> IO.inspect()

    {scrubber_rating, ""} =
      calculate_scrubber_rating(list, 0) |> Enum.join() |> Integer.parse(2) |> IO.inspect()

    generator_rating * scrubber_rating
  end

  def calculate_generator_rating(list, index) when length(list) > 1 do
    return_list = count(list, index)

    index = index + 1

    if length(return_list.one) >= length(return_list.zero) do
      calculate_generator_rating(return_list.one, index)
    else
      calculate_generator_rating(return_list.zero, index)
    end
  end

  def calculate_generator_rating(list, _index), do: list

  def calculate_scrubber_rating(list, index) when length(list) > 1 do
    return_list = count(list, index)

    index = index + 1

    if length(return_list.one) < length(return_list.zero) do
      calculate_scrubber_rating(return_list.one, index)
    else
      calculate_scrubber_rating(return_list.zero, index)
    end
  end

  def calculate_scrubber_rating(list, _index), do: list

  def count(list, index) do
    Enum.reduce(list, %{zero: [], one: []}, fn x, acc ->
      if Enum.at(x, index) == "1" do
        Map.replace(acc, :one, acc.one ++ [x])
      else
        Map.replace(acc, :zero, acc.zero ++ [x])
      end
    end)
  end
end

defmodule Part1 do
  def a() do
    list = "lib/data.txt" |> File.read!() |> String.trim() |> String.split("\n")
    # list = ["199", "200", "208", "210", "200", "207", "240", "269", "260", "263"]

    list =
      Enum.map(list, fn x ->
        {value, _} = Integer.parse(x)
        value
      end)

    list
    |> Enum.with_index()
    |> Enum.map(fn {value, index} ->
      if index != 0 do
        if value > Enum.at(list, index - 1) do
          {:ok, :increased}
        else
          {:error, :decreased}
        end
      else
        {:error, "N/A - no previous measurement"}
      end
    end)
    |> Enum.count(fn x ->
      {:ok, :increased} == x
    end)
  end
end

defmodule Part2 do
  def a() do
    list = "lib/data.txt" |> File.read!() |> String.trim() |> String.split("\n")
    # list = ["199", "200", "208", "210", "200", "207", "240", "269", "260", "263"]

    list =
      Enum.map(list, fn x ->
        {value, _} = Integer.parse(x)
        value
      end)

    list
    |> Enum.with_index()
    |> Enum.map(fn {value, index} ->
      if index != 0 && index < length(list) - 2 do
        sum = Enum.at(list, index - 1) + value + Enum.at(list, index + 1)
        sum2 = value + Enum.at(list, index + 1) + Enum.at(list, index + 2)

        if sum < sum2 do
          {:ok, :increased}
        else
          {:error, :decreased}
        end
      else
        {:error, "N/A - no previous measurement"}
      end
    end)
    |> Enum.count(fn x ->
      {:ok, :increased} == x
    end)
  end
end

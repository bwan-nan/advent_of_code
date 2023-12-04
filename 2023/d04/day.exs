day =
  File.read!("input.txt")
  |> String.split("\n", trim: true)
  |> Enum.with_index()
  |> Enum.reduce(%{part1: %{}}, fn {line, i}, acc ->
    acc =
      acc
      |> Map.put(i, Map.get(acc, i, 0) + 1)

    [_, numbers] = String.split(line, ":", trim: true)

    [winning_numbers, my_numbers] =
      numbers
      |> String.split("|")
      |> Enum.map(fn list ->
        String.split(list, " ", trim: true)
        |> Enum.map(&String.to_integer(&1))
        |> MapSet.new()
      end)

    matches =
      MapSet.intersection(winning_numbers, my_numbers)
      |> Enum.count()

    if matches > 0 do
      acc =
        for j <- 1..matches, reduce: acc do
          acc ->
            current_val = Map.get(acc, i)
            Map.put(acc, i + j, current_val + Map.get(acc, i + j, 0))
        end

      put_in(acc, [:part1, i], 2 ** (matches - 1))
    else
      put_in(acc, [:part1, i], 0)
    end
  end)

Map.get(day, :part1) |> Map.values() |> Enum.sum() |> IO.puts()
Map.delete(day, :part1) |> Map.values() |> Enum.sum() |> IO.puts()

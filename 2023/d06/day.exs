lines =
  File.read!("input.txt")
  |> String.split("\n", trim: true)

[times, distances] =
  lines
  |> Enum.map(fn line ->
    line
    |> String.split(":")
    |> List.last()
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end)

[t2, d2] =
  lines
  |> Enum.map(fn line ->
    line
    |> String.split(":")
    |> List.last()
    |> String.replace(~r/\s+/, "")
    |> String.to_integer()
  end)

times = [t2 | times]
distances = [d2 | distances]

[p2 | nb_of_ways_to_beat_record] =
  times
  |> Enum.with_index()
  |> Enum.map(fn {time, i} ->
    1..time
    |> Enum.reduce(0, fn t, acc ->
      if t * (time - t) > Enum.at(distances, i),
        do: acc + 1,
        else: acc
    end)
  end)

nb_of_ways_to_beat_record
|> Enum.reduce(1, fn n, acc -> n * acc end)
|> IO.puts()

IO.puts(p2)

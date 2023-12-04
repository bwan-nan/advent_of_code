defmodule Day do
  def run(part, input \\ "input.txt")

  def run("part1", input) do
    input
    |> read_input()
    |> build_engine_schematic()
    |> sum_numbers_adjacent_to_symbol()
  end

  def run("part2", input) do
    input
    |> read_input()
    |> build_engine_schematic()
    |> compute_gear_ratio()
  end

  defp build_engine_schematic({lines, nb_lines, nb_col}) do
    for {line, j} <- lines,
        {char, i} <- (line <> ".") |> String.to_charlist() |> Enum.with_index(),
        reduce: %{} do
      # Not a digit AND the construction of a number can be completed
      {acc, n, part_number_info} when char not in ?0..?9 ->
        acc
        |> update_gear_info(n, part_number_info)
        |> update_part_numbers_list(n, part_number_info)

      # Digit match: continue to build a number
      {acc, n, %{is_part_number: true} = pn_info} when char in ?0..?9 ->
        {acc, n * 10 + char - ?0, pn_info}

      # Digit match: continue to build a number
      {acc, n, %{is_part_number: false}} when char in ?0..?9 ->
        part_number_info = get_part_number_info(lines, i, j, nb_lines, nb_col)
        {acc, n * 10 + char - ?0, part_number_info}

      # Digit match: start building a number
      acc when char in ?0..?9 ->
        part_number_info = get_part_number_info(lines, i, j, nb_lines, nb_col)
        {acc, char - ?0, part_number_info}

      # Dot match: do nothing
      acc when char == ?. ->
        acc

      # Return list of tuples: [{number, is_part_number}]
      acc ->
        acc
    end
  end

  defp get_part_number_info(lines, i, j, nb_lines, nb_col) do
    for x <- [-1, 0, 1],
        y <- [-1, 0, 1],
        (y + j) in 0..(nb_lines - 1) and (x + i) in 0..(nb_col - 1),
        c = Enum.at(lines, y + j) |> elem(0) |> String.to_charlist() |> Enum.at(x + i),
        c != ?. and c not in ?0..?9,
        reduce: %{is_part_number: false} do
      acc when c == ?* ->
        gear_positions = Map.get(acc, :gear_positions, [])

        %{
          is_part_number: true,
          gear_positions: [{x + i, y + j} | gear_positions]
        }

      acc ->
        %{acc | is_part_number: true}
    end
  end

  defp update_gear_info(engine_schematic, current_number, part_number_info) do
    part_number_info
    |> Map.get(:gear_positions, [])
    |> Enum.reduce(engine_schematic, fn gear_position, acc ->
      gears =
        engine_schematic
        |> Map.get(:gears, %{})

      gears_for_position =
        gears
        |> Map.get(gear_position, [])

      gears =
        gears
        |> Map.put(gear_position, [current_number | gears_for_position])

      Map.put(acc, :gears, gears)
    end)
  end

  defp update_part_numbers_list(engine_schematic, current_number, part_number_info) do
    is_part_number =
      part_number_info
      |> Map.get(:is_part_number)

    numbers_list =
      engine_schematic
      |> Map.get(:numbers, [])

    engine_schematic
    |> Map.put(:numbers, [{current_number, is_part_number} | numbers_list])
  end

  defp sum_numbers_adjacent_to_symbol(engine_schematic) do
    engine_schematic
    |> Map.get(:numbers)
    |> Enum.filter(fn {_n, is_part_number} -> is_part_number end)
    |> Enum.map(fn {n, _} -> n end)
    |> Enum.sum()
  end

  defp compute_gear_ratio(engine_schematic) do
    engine_schematic
    |> Map.get(:gears)
    |> Enum.filter(fn {_, numbers_adjacent_to_gear} ->
      Enum.count(numbers_adjacent_to_gear) == 2
    end)
    |> Enum.reduce(0, fn {_, numbers_adjacent_to_gears}, acc ->
      gear_power =
        numbers_adjacent_to_gears
        |> Enum.reduce(1, fn n, acc -> n * acc end)

      acc + gear_power
    end)
  end

  defp read_input(input) do
    lines =
      input
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.with_index()

    nb_lines = lines |> Enum.count()
    nb_col = lines |> hd |> elem(0) |> String.length()
    {lines, nb_lines, nb_col}
  end
end

Day.run("part1") |> IO.inspect()
Day.run("part2") |> IO.inspect()

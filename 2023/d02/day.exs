defmodule Day do
  @elf_bag %{
    "red" => 12,
    "green" => 13,
    "blue" => 14
  }

  def run(part, file \\ "input.txt")

  def run("part1", file) do
    read_file(file)
    |> parse_game()
    |> filter_possible_games()
    |> Enum.sum()
  end

  def run("part2", file) do
    read_file(file)
    |> parse_game()
    |> get_minimum_cubes_required_per_game()
    |> compute_cubes_power()
    |> Enum.sum()
  end

  defp read_file(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
  end

  defp parse_game(lines) do
    lines
    |> Enum.map(fn line ->
      [_, game] = String.split(line, ": ")

      game
      |> String.split("; ")
      |> Enum.map(fn set ->
        set
        |> String.split(", ")
        |> Enum.reduce(%{}, fn cubes, acc ->
          [number, color] = String.split(cubes, " ")

          Map.put(acc, color, String.to_integer(number))
        end)
      end)
    end)
  end

  defp filter_possible_games(games) do
    games
    |> Enum.with_index()
    |> Enum.reduce_while([], fn {game, index}, acc ->
      if all_sets_possible?(game),
        do: {:cont, acc ++ [index + 1]},
        else: {:cont, acc}
    end)
  end

  defp all_sets_possible?(game) do
    game
    |> Enum.all?(fn sets ->
      sets
      |> Enum.all?(fn {color, n} -> n <= @elf_bag[color] end)
    end)
  end

  defp get_minimum_cubes_required_per_game(games) do
    games
    |> Enum.reduce([], fn game, acc ->
      cubes =
        game
        |> Enum.reduce(%{"red" => 0, "blue" => 0, "green" => 0}, fn sets, cubes_required ->
          Enum.reduce(sets, cubes_required, fn {color, n}, cubes_required ->
            if Map.get(cubes_required, color) < n,
              do: Map.put(cubes_required, color, n),
              else: cubes_required
          end)
        end)

      [cubes | acc]
    end)
  end

  defp compute_cubes_power(cubes_required_per_game) do
    cubes_required_per_game
    |> Enum.map(fn game ->
      game
      |> Enum.reduce(1, fn {_, number}, acc -> number * acc end)
    end)
  end
end

Day.run("part1") |> IO.puts()
Day.run("part2") |> IO.puts()

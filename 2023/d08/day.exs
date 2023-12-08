defmodule Day do
  def compute_steps_to_reach_stop(start, stop, nodes, instructions) do
    instructions
    |> Stream.cycle()
    |> Stream.with_index()
    |> Enum.reduce_while(start, fn {current_instruction, steps}, current_node ->
      if current_node |> String.ends_with?(stop),
        do: {:halt, steps},
        else: {:cont, get_in(nodes, [current_node, current_instruction])}
    end)
  end

  def nodes_to_dig(nodes) do
    nodes
    |> Map.keys()
    |> Enum.filter(&String.ends_with?(&1, "A"))
  end

  def get_nodes(lines) do
    lines
    |> Enum.reduce(%{}, fn line, acc ->
      [start, connections] = line |> String.split(" = ")

      [left, right] =
        connections
        |> String.replace(~r/\(|\)/, "")
        |> String.split(", ")

      Map.put(acc, start, %{"L" => left, "R" => right})
    end)
  end
end

[instructions | lines] =
  File.read!("input.txt")
  |> String.split("\n", trim: true)

instructions = instructions |> String.graphemes()

nodes = Day.get_nodes(lines)

Day.compute_steps_to_reach_stop("AAA", "ZZZ", nodes, instructions) |> IO.puts()

Day.nodes_to_dig(nodes)
|> Enum.reduce(1, fn current_node, acc ->
  steps = Day.compute_steps_to_reach_stop(current_node, "Z", nodes, instructions)
  div(steps * acc, Integer.gcd(steps, acc))
end)
|> IO.puts()

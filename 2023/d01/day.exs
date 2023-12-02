defmodule Day do
  @dict %{
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5,
    "six" => 6,
    "seven" => 7,
    "eight" => 8,
    "nine" => 9
  }

  def run(part, input \\ "input.txt") do
    read_file(input)
    |> Enum.map(fn line ->
      line
      |> get_digits_list(part)
      |> group_first_and_last_digit()
    end)
    |> Enum.sum()
  end

  defp read_file(input) do
    File.read!(input)
    |> String.split()
  end

  defp group_first_and_last_digit(digits) do
    "#{List.first(digits)}#{List.last(digits)}"
    |> String.to_integer()
  end

  defp get_digits_list(line, "part1") do
    line
    |> String.graphemes()
    |> Enum.filter(fn c -> match?({_, ""}, Integer.parse(c)) end)
  end

  defp get_digits_list(line, "part2") do
    0..(String.length(line) - 1)
    |> Enum.reduce_while([], fn i, acc ->
      l = line |> String.slice(i..-1)
      first_char = String.first(l)

      case Integer.parse(first_char) do
        {_, ""} ->
          {:cont, acc ++ [first_char]}

        _ ->
          digit_in_letters = get_digit_in_letters(l)
          {:cont, acc ++ [Map.get(@dict, digit_in_letters)]}
      end
    end)
    |> Enum.reject(&is_nil/1)
  end

  defp get_digit_in_letters(line) do
    @dict
    |> Map.keys()
    |> Enum.find(fn digit ->
      String.starts_with?(line, digit)
    end)
  end
end

IO.puts(Day.run("part1"))
IO.puts(Day.run("part2"))

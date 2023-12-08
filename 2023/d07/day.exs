defmodule Day do
  @hand_strengths_map %{
    "five_of_a_kind" => 7,
    "four_of_a_kind" => 6,
    "full_house" => 5,
    "three_of_a_kind" => 4,
    "two_pair" => 3,
    "one_pair" => 2,
    "high_card" => 1
  }

  def run(lines, part) do
    lines
    |> Enum.map(fn [hand, bid] -> build_hand_details(hand, bid, part) end)
    |> Enum.sort(fn a, b -> compare(a, b) end)
    |> calculate_winnings()
  end

  def build_hand_details(hand, bid, part) do
    %{
      bid: String.to_integer(bid),
      value: hand,
      hand_strength: hand_strength(hand, part),
      card_strengths: compute_card_strengths(hand, part)
    }
  end

  defp compute_card_strengths(hand, part) do
    hand
    |> cards()
    |> Enum.map(fn card ->
      card_strengths_map(part) |> Map.get(card)
    end)
  end

  defp calculate_winnings(hands) do
    hands
    |> Enum.with_index()
    |> Enum.reduce(0, fn {hand, i}, acc ->
      acc + Map.get(hand, :bid) * (i + 1)
    end)
  end

  defp cards(hand) do
    hand
    |> String.graphemes()
  end

  defp hand_strength(hand, "part1") do
    hand_type =
      hand
      |> cards()
      |> hand_type()

    Map.get(@hand_strengths_map, hand_type)
  end

  defp hand_strength(hand, "part2") do
    card_to_mimick =
      hand
      |> cards()
      |> group_cards_by_value()
      |> Map.delete("J")
      |> Enum.sort_by(fn {_card, occurrence} -> -occurrence end)
      |> List.first({"J", 5})
      |> elem(0)

    hand
    |> String.replace("J", card_to_mimick)
    |> hand_strength("part1")
  end

  def group_cards_by_value(cards) do
    cards
    |> Enum.reduce(%{}, fn card, acc ->
      current_value = Map.get(acc, card, 0)
      Map.put(acc, card, current_value + 1)
    end)
  end

  def hand_type(cards) do
    case cards
         |> group_cards_by_value()
         |> Map.values()
         |> Enum.sort() do
      [5] -> "five_of_a_kind"
      [1, 4] -> "four_of_a_kind"
      [2, 3] -> "full_house"
      [1, 1, 3] -> "three_of_a_kind"
      [1, 2, 2] -> "two_pair"
      [1, 1, 1, 2] -> "one_pair"
      [1, 1, 1, 1, 1] -> "high_card"
    end
  end

  defp compare(%{hand_strength: h1}, %{hand_strength: h2}) when h1 < h2, do: true

  defp compare(%{hand_strength: h1}, %{hand_strength: h2}) when h1 > h2, do: false

  defp compare(%{card_strengths: cards1}, %{card_strengths: cards2}) do
    cards1
    |> Enum.with_index()
    |> Enum.reduce_while(0, fn {card1, i}, _ ->
      card2 = Enum.at(cards2, i)

      cond do
        card1 < card2 ->
          {:halt, true}

        card1 > card2 ->
          {:halt, false}

        true ->
          {:cont, true}
      end
    end)
  end

  defp card_strengths_map("part1") do
    %{
      "A" => 14,
      "K" => 13,
      "Q" => 12,
      "J" => 11,
      "T" => 10,
      "9" => 9,
      "8" => 8,
      "7" => 7,
      "6" => 6,
      "5" => 5,
      "4" => 4,
      "3" => 3,
      "2" => 2
    }
  end

  defp card_strengths_map("part2") do
    %{
      "A" => 14,
      "K" => 13,
      "Q" => 12,
      "T" => 10,
      "9" => 9,
      "8" => 8,
      "7" => 7,
      "6" => 6,
      "5" => 5,
      "4" => 4,
      "3" => 3,
      "2" => 2,
      "J" => 1
    }
  end
end

lines =
  File.read!("input.txt")
  |> String.split("\n", trim: true)
  |> Enum.map(fn line -> line |> String.split(" ") end)

Day.run(lines, "part1") |> IO.puts()
Day.run(lines, "part2") |> IO.puts()

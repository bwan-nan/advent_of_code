UNORDERED = 1
ORDERED = -1
EQUALITY = 0

$hand_strengths = {
  "five_of_a_kind" => 7,
  "four_of_a_kind" => 6,
  "full_house" => 5,
  "three_of_a_kind" => 4,
  "two_pair" => 3,
  "one_pair" => 2,
  "high_card" => 1
}

$card_strengths_p1 = {
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

$card_strengths_p2 = {
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

def group_cards_by_value(hand)
  hand.inject(Hash.new(0)) do |h, card|
    h[card] += 1
    h
  end
end

def hand_type(hand)
  case group_cards_by_value(hand).values.sort
  when [5] then "five_of_a_kind"
  when [1, 4] then "four_of_a_kind"
  when [2, 3] then "full_house"
  when [1, 1, 3] then "three_of_a_kind"
  when [1, 2, 2] then "two_pair"
  when [1, 1, 1, 2] then "one_pair"
  when [1, 1, 1, 1, 1] then "high_card"
  end
end

def hand_strength(hand, part)
  hand_type = hand_type(hand.chars)
  hand_strength = $hand_strengths[hand_type]

  return hand_strength if part == "part1"

  card_to_mimick = group_cards_by_value(hand.chars)
                    .except("J")
                    .sort_by {|card, occurrence| -occurrence}
                    &.first&.first || "J"

  hand_strength(hand.gsub("J", card_to_mimick), "part1")
end

def compare(h1, h2)
  return ORDERED if h1[:hand_strength] < h2[:hand_strength]
  return UNORDERED if h1[:hand_strength] > h2[:hand_strength]

  h1[:card_strengths].each_with_index do |card1, i|
    card2 = h2[:card_strengths][i]
    next if card1 == card2
    return ORDERED if card1 < card2
    return UNORDERED if card1 > card2
  end
  EQUALITY
end

def card_strengths(hand, part)
  h = part == "part1" ? $card_strengths_p1 : $card_strengths_p2
  hand.chars.map {|card| h[card]}
end

def build_hands_details(hand, bid, part)
  {
    bid: bid.to_i,
    value: hand,
    hand_strength: hand_strength(hand, part),
    card_strengths: card_strengths(hand, part)
  }
end

def calculate_winnings(hands)
  hands.map.with_index do |hand, i|
    hand[:bid] * (i + 1)
  end.sum
end

def run(lines, part)
  hands = lines.map do |hand, bid|
    build_hands_details(hand, bid, part)
  end.sort {|h1, h2| compare(h1, h2)}

  calculate_winnings(hands)
end

lines = File.readlines('input.txt').map {|l| l.strip.split(" ")}

puts run(lines, "part1")
puts run(lines, "part2")

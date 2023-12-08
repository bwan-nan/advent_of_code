def compute_steps_to_reach_stop(start, stop, nodes, instructions)
  current_node = start
  instructions.cycle.with_index do |current_instruction, steps|
    return steps if current_node.end_with?(stop)
    current_node = nodes[current_node][current_instruction]
  end
end

lines = File.readlines('input.txt').map {|l| l.strip if !l.strip.empty?}.compact
instructions = lines.shift.chars
nodes = {}

lines.map do |line|
  start, connections = line.split(" = ")
  left, right = connections.gsub(/\(|\)/, "").split(", ")
  nodes[start] = {"L" => left, "R" => right}
end

puts compute_steps_to_reach_stop("AAA", "ZZZ", nodes, instructions)

nodes_to_dig = nodes.keys.select {|node| node.end_with?("A")}

steps_per_node = nodes_to_dig.map do |current_node|
  compute_steps_to_reach_stop(current_node, "Z", nodes, instructions)
end

puts steps_per_node.reduce(1) {|acc, n| acc.lcm(n)}

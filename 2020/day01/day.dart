import 'dart:async';
import 'dart:io';
import 'dart:core';

Iterable<int> _readInput() =>
  File('input.txt').readAsLinesSync().map(int.parse);

int part1(List<int> list) {
  for (var a = 0; a < list.length; a++)
    for (var b = a + 1; b < list.length; b++)
      if (list[a] + list[b] == 2020)
	return (list[a] * list[b]);
}

int part2(List<int> list) {
  for (var a = 0; a < list.length; a++)
    for (var b = a + 1; b < list.length; b++)
      for (var c = b + 1; c < list.length; c++)
	if (list[a] + list[b] + list[c] == 2020)
	  return (list[a] * list[b] * list[c]);
}

void main() {
  final list = _readInput().toList();
  print(part1(list));
  print(part2(list));
}

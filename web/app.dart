import 'board.dart';

// Example usage of the board.
void main() {
  var board = new Board("#goban");

  board.onClick.listen((coords) => board.playAt(coords.x, coords.y, 'black'));
  board.onHover.listen((coords) => board.hoverAt(coords.x, coords.y, 'black'));
}
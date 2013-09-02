# Goban Widget

This is a dart implementation of a go board.
The board library has no game logic at all,
it only serves as a visual representation of a board,
and defines an API to use it.

It can be used by calling the constructor and passing a css selector of
an element to be used as the container:

`var board = new Board('#goban');`

### Usage:

The board exports `onClick` and `onHover` streams, passing the
parsed board coordinates as a `Point` (e.g.: `new Point(3,3)`).

### Available methods:

* `playAt(int x, int y, [String color = 'black'])` // Draws the stone on the board at the given coords.
* `hoverAt(int x, int y, [String color = 'black'])` // Adds a semi-transparent stone at the given coords.
* `markAt(int x, int y,[String color = 'black'])` // Adds a circle marker at the given coords.
* `killAt(int x, int y)` // Removes the stone from the board at the given coords.

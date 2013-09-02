# Goban Widget

This is a dart implementation of a go board.
The board library has no game logic at all,
it only serves as a visual representation of a board,
and defines an API to use it.

Here's what the board looks like with the default css theme provided:

![goban](http://f.cl.ly/items/43270i0A2S0j0c270k2F/Screen%20Shot%202013-09-02%20at%205.18.51%20PM.png)

### Usage:

It can be used by calling the constructor and passing a css selector of
an element to be used as the container:

`var board = new Board('#goban');`

The board exports `onClick` and `onHover` streams, passing the
parsed board coordinates as a `Point` (e.g.: `new Point(3,3)`).

### Available methods:

* `playAt(int x, int y, [String color = 'black'])` // Draws the stone on the board at the given coords.
* `hoverAt(int x, int y, [String color = 'black'])` // Adds a semi-transparent stone at the given coords.
* `markAt(int x, int y,[String color = 'black'])` // Adds a circle marker at the given coords.
* `killAt(int x, int y)` // Removes the stone from the board at the given coords.

# License

The MIT License (MIT)

Copyright (c) 2013 Lucas Nasif

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

import 'dart:html';
import 'dart:math';

void main() {
  var board = new Board("#goban");
}

class Board {
  Element container;
  Map<String, CanvasElement> layers = {};
  int size;
  int paddingTop;
  int lineGap;
  int stoneRadius;
  List drawnStones;
  Point hoveredStone;

  final stonesImage = new ImageElement(src: "../images/stones-sprite-smallest.png");

  Board(container) {
    this.container = query(container);
    this.paddingTop = 120;
    this.drawnStones = [];

    createCanvasElements();
    calculateStoneSize();

    stonesImage.onLoad.listen((evt) => render());
  }

  void createCanvasElements() {
    for (final layer in ["buffer", "board", "stones", "markers", "hover"]) {
      final canvasLayer = new CanvasElement();

      canvasLayer.id = layer;
      canvasLayer.classes.add(layer);

      layers[layer] = canvasLayer;

      container.children.add(canvasLayer);
    }

    calculateBoardSize();
  }

  void calculateBoardSize() {
    var width  = px2Int(container.parent.getComputedStyle().width);
    var height = px2Int(container.parent.getComputedStyle().height) - this.paddingTop;

    this.size = min(width, height);

    var sizePx = size.toString() + "px";

    container.style..height = sizePx
                   ..width  = sizePx;

    for (final layer in layers.keys) {
      layers[layer].style..height = sizePx
                         ..width  = sizePx;
      layers[layer]..width  = size
                   ..height = size;
    }
  }

  void calculateStoneSize() {
    this.lineGap = (this.size / 19).round();
    this.stoneRadius = (this.lineGap / 2).round();
  }

  void render() {
    drawLines();
    drawStars();

    markLastPlayed();
    drawPlayedStones();
  }

  void drawLines() {
    var context = this.layers["board"].context2D;

    for (var i = 1; i < 20; i++) {
      var fc = getCoords(1, i);
      var tc = getCoords(19, i);

      // Vertical lines.
      context..beginPath()
             ..lineWidth = this.lineGap / 35
             ..moveTo(fc.x, fc.y)
             ..lineTo(tc.x, tc.y)
             ..stroke();

      fc = getCoords(i, 1);
      tc = getCoords(i, 19);

      // Horizontal lines.
      context..beginPath()
             ..lineWidth = this.lineGap / 35
             ..moveTo(fc.x, fc.y)
             ..lineTo(tc.x, tc.y)
             ..stroke();
    }
  }

  void drawStars() {
    var context = this.layers["board"].context2D;

    for (var coord in [[4,4],[10,4],[16,4],[4,10],[10,10],[16,10],[4,16],[10,16],[16,16]]) {
      coord = getCoords(coord[0],coord[1]);

      context..beginPath()
             ..arc(coord.x, coord.y, lineGap / 10,0, PI * 2, true)
             ..fillStyle = 'black'
             ..fill()
             ..stroke();
    }
  }

  void markLastPlayed() {
    if (this.drawnStones.length > 0) {
      var lastPlayed = this.drawnStones.last;
      markAt(lastPlayed[0], lastPlayed[1], lastPlayed[2]);
    }
  }

  void markAt(int x, int y, String color) {
    var coords = getCoords(x, y);

    clearLayer('markers');

    var context = this.layers['markers'].context2D;

    context..beginPath()
           ..lineWidth = this.lineGap / 20
           ..strokeStyle = color == 'black' ? '#c9c6c0' : '#5d5856'
           ..arc(coords.x, coords.y, this.stoneRadius / 2, 0, PI * 2, true)
           ..stroke();
  }

  void drawPlayedStones() {
    if (this.drawnStones.length > 0) {
      for (final stone in this.drawnStones) {
        drawStone(stone[0], stone[1], stone[2], "buffer");
      }
    }

    this.layers['stones'].context2D.drawImage(this.layers['buffer'], 0, 0);
  }

  void drawStone(int x, int y, String color, [String layer = 'stones']) {
    var context = this.layers[layer].context2D;

    var coords          = getCoords(x, y);
    var sprite_img_size = 63;
    var img_size        = this.stoneRadius * 2;
    var img_x           = (coords.x - img_size / 2).round();
    var img_y           = (coords.y - img_size / 2).round();
    var sprite_img_x;
    var sprite_img_y;

    if (color == 'black') {
      sprite_img_x = 3.5;
      sprite_img_y = 3.5;
    } else {
      sprite_img_x = 74;
      sprite_img_y = 74 + 70 * new Random().nextInt(3);
    }

    context.drawImageScaledFromSource(stonesImage, sprite_img_x, sprite_img_y,
                                      sprite_img_size, sprite_img_size, img_x,
                                      img_y, img_size, img_size);
  }

  void playAt(int x,int y, [String color = "black"]) {
    if (stonePlayedAt(x,y)) return;

    this.drawnStones.add([x, y, color]);

    drawStone(x,y,color);
    markLastPlayed();
  }

  void hoverAt(int x, int y, [String color = 'black']) {
    if (stoneHoveredAt(x,y)) return;

    clearLayer('hover');
    this.hoveredStone = null;

    if (!stonePlayedAt(x,y)) {
      this.hoveredStone = new Point(x,y);
      drawStone(x,y,color,'hover');
    }
  }

  bool stonePlayedAt(int x, int y) =>
      this.drawnStones.any((stone) => stone[0] == x && stone[1] == y);

  bool stoneHoveredAt(int x, int y) =>
      (hoveredStone != null) && hoveredStone.x == x && hoveredStone.y == y;

  void clearLayer(String layer) =>
      this.layers[layer].context2D.clearRect(0, 0, this.size, this.size);

  // For a given pair of game coords, like 2,2,
  // return the actual canvas position coords like 53.5, 53.5.
  Point getCoords(int x, int y) =>
    new Point(stoneRadius + lineGap * (x-1), stoneRadius + lineGap * (y-1));

  int px2Int(String style) => double.parse(style.replaceAll("px", "")).round();
}
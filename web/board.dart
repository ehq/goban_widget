import 'dart:html';
import 'dart:math';

void main() {
  new Board("#goban");
}

class Board {
  Element container;
  Map<String, CanvasElement> layers = {};
  int size;
  int paddingTop;
  int lineGap;
  int stoneRadius;

  final stonesImage = new ImageElement(src: "../images/stones-sprite-smallest.png");

  Board(container) {
    this.container = query(container);
    this.paddingTop = 120;

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

    //markLastPlayed();
    //drawPlayedStones();
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

    for (var coord in [[4,4],[10,4],[16,4],[4,10],
                       [10,10],[16,10],[4,16],[10,16],[16,16]]) {
      coord = getCoords(coord[0],coord[1]);

      context..beginPath()
             ..arc(coord.x, coord.y, lineGap / 10,0, PI * 2, true)
             ..fillStyle = 'black'
             ..fill()
             ..stroke();
    }
  }

  // For a given pair of coords, like 2,2,
  // return the actual canvas coords like 53.5, 53.5.
  Point getCoords(x,y) =>
    new Point(stoneRadius + lineGap * (x-1), stoneRadius + lineGap * (y-1));

  int px2Int(String style) => double.parse(style.replaceAll("px", "")).round();
}
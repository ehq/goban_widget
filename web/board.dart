import 'dart:html';
import 'dart:math';

void main() {
  new Board("#goban");
}

class Board {
  Element container;

  Map<String, Element> layers = {};
  int size;
  int paddingTop;
  int lineGap;
  int stoneRadius;

  Board(container) {
    this.container = query(container);
    this.paddingTop = 120;

    createCanvasElements();
    calculateStoneSize();
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
    }
  }

  void calculateStoneSize() {
    this.lineGap = (this.size / 19).round();
    this.stoneRadius = (this.lineGap / 2).round();
  }

  int px2Int(String style) => double.parse(style.replaceAll("px", "")).round();
}
import 'dart:html';
import 'dart:math';

void main() {
  new Board("#goban");
}

class Board {
  Element container;

  Map<String, Element> layers = {};
  int boardMargin;
  int size;
  double lineGap;
  double stoneRadius;

  Board(container) {
    this.container = query(container);
    this.boardMargin = 70;

    createCanvasElements();
    calculateStoneSize();
  }

  void createCanvasElements() {
    for (final layer in ["buffer", "goban", "stones", "markers", "hover"]) {
      final canvasLayer = new CanvasElement();

      canvasLayer.id = layer;
      canvasLayer.classes.add(layer);

      layers[layer] = canvasLayer;

      container.children.add(canvasLayer);
    }

    positionCanvasElements();
  }

  void positionCanvasElements() {
    var minWidth = px2Int(container.parent.getComputedStyle().minWidth);
    var height = px2Int(container.parent.getComputedStyle().height);

    this.size = (max(minWidth, height) - boardMargin);

    var sizePx = size.toString() + "px";

    container.style.width = sizePx;

    for (final layer in layers.keys) {
      layers[layer].style..height = sizePx
                         ..width  = sizePx;
    }
  }

  void calculateStoneSize() {
    this.lineGap = this.size / 19;
    this.stoneRadius = this.lineGap / 2;
  }

  int px2Int(String style) => int.parse(style.replaceAll("px", ""));
}
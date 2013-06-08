import 'dart:html';

void main() {
  new Board("#goban");
}

class Board {
  Element container;

  String nextMove = 'black';
  List drawnStones;
  List hoveredStones;
  Map<String, Element> layers = {};

  Board(container) {
    this.container = query(container);

    createCanvasElements();
  }

  void createCanvasElements() {
    for (final layer in ["buffer", "goban", "stones", "markers", "hover"]) {
      final canvasLayer = new CanvasElement();

      canvasLayer.id = layer;
      canvasLayer.classes.add(layer);

      this.layers[layer] = canvasLayer;

      container.children.add(canvasLayer);
    }
  }
}
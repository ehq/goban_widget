part of board;

class ElementOffset {
  num left, top;

  ElementOffset(Element elem) {
    final docElem = document.documentElement;
    final box = elem.getBoundingClientRect();

    this.left = box.left + window.pageXOffset - docElem.clientLeft;
    this.top  = box.top  + window.pageYOffset - docElem.clientTop;
  }
}
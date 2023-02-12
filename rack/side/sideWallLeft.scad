include <./sideWallBase.scad>


*sideWallLeft();

module sideWallLeft() {

  applyEpicVentilation()
  sideWallBase();

  module applyEpicVentilation() {
    children(0);
  }
}


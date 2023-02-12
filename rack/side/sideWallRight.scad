include <./sideWallBase.scad>

*sideWallRight();

module sideWallRight() {

  applyEpicVentilation()
  mirror(v=[1,0,0])
  sideWallBase();

  module applyEpicVentilation() {
    children(0);
  }
}


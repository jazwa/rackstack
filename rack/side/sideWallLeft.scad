include <./sideWallBase.scad>

*sideWallLeft();

module sideWallLeft() {

  //applyEpicVentilation()
  //applySideWallVerticalRibs()
  //render()
  sideWallBase();

  module applyEpicVentilation() {
    apply_n() {
      for (i = [1:8]) {
        translate(v = [0, 35, i * 10 + 8])
        vent();
      }
      children(0);
    }

    module vent() {
      minkowski() {
        sphere(r=1);
        cube(size = [10, 40, 3]);
      }
    }
  }

  module applySideWallVerticalRibs() {
    apply_p() {
      union() {
        translate(v = [0, 82, 0])
        sideWallVerticalRibs(numRibs = 2, ribZ = sideWallZ, ribYDiff = 8, ribExtrusion = 1.5);

        translate(v = [0, 18, 0])
        sideWallVerticalRibs(numRibs = 2, ribZ = sideWallZ, ribYDiff = 8, ribExtrusion = 1.5);
      }
      children(0);
    }
  }
}


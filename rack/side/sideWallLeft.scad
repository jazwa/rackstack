include <./sideWallBase.scad>

*sideWallLeft();

module sideWallLeft() {

  applySideWallVerticalRibs()
  //applyEpicVentilation()
  sideWallBase();

  module applyEpicVentilation() {
    apply_n() {
      for (i = [1:8]) {
        translate(v = [0, 41, i * 18 + 10])
        vent();
      }
      children(0);
    }

    module vent() {
      minkowski() {
        rotate(a=[0,90,0])
        cylinder(r=1,h=1);

        cube(size = [10, 80, 5]);
      }
    }
  }

  module applySideWallVerticalRibs() {
    apply_p() {
      translate(v = [0, 20, 0])
      sideWallVerticalRibs(numRibs = 9, ribZ = sideWallZ, ribYDiff = 20, ribExtrusion = 1.5);

      children(0);
    }
  }
}


include <./sideWallBase.scad>

*sideWallRight();

module sideWallRight() {

  //applyEpicVentilation()
  mirror(v=[1,0,0])
  applySideWallVerticalRibs()
  //render()
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
        sphere(r=1);
        cube(size = [10, 40, 3]);
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


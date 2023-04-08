include <./sideWallBase.scad>

*sideWallRight();

module sideWallRight() {

  applyEpicVentilation()
  mirror(v=[1,0,0])
  applySideWallVerticalRibs()
  sideWallBase();

  module applyEpicVentilation() {

    apply_n() {

      for (i = [1:8]) {
        translate(v = [-10, 35, i * 10 + 8])
        minkowski() {
          sphere(r=1);
          cube(size = [10, 40, 3]);
        }
      }

      children(0);
    }

  }

  module applySideWallVerticalRibs() {
    apply_p() {
      union() {
        translate(v = [0, 82, 0])
        sideWallVerticalRibs(numRibs = 2, ribZ = sideWallZ-20, ribYDiff = 8, ribR = 3, ribExtrusion = 1.5);

        translate(v = [0, 12, 0])
        sideWallVerticalRibs(numRibs = 3, ribZ = sideWallZ-20, ribYDiff = 8, ribR = 3, ribExtrusion = 1.5);
      }
      children(0);
    }
  }
}


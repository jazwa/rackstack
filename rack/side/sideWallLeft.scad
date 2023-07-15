include <./sideWallBase.scad>

sideWallLeft();

module sideWallLeft() {

  applySideWallVerticalRibs()
  applyEpicVentilation()
  sideWallBase();

  module applyEpicVentilation() {
    apply_n() {
      for (i = [1:8]) {
        translate(v = [0, 41, i * 12 + 10])
        vent();
      }
      children(0);
    }

    module vent() {
      minkowski() {
        rotate(a=[0,90,0])
        cylinder(r=2,h=1);

        cube(size = [10, 100, 1]);
      }
    }
  }

  module applySideWallVerticalRibs() {
    echo("sideWallZ", sideWallZ);
    apply_p() {
      translate(v = [0, 30, 0])
      sideWallVerticalRibs(numRibs = 2, ribZ = sideWallZ, ribYDiff = 120, ribExtrusion = 1.5);

      children(0);
    }
  }
}


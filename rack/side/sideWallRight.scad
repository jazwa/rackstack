include <./sideWallBase.scad>

*sideWallRight();

module sideWallRight() {

  applyEpicVentilation()
  mirror(v=[1,0,0])
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
}


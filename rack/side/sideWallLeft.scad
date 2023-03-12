include <./sideWallBase.scad>


sideWallLeft();

module sideWallLeft() {

  applyEpicVentilation()
  sideWallBase();

  module applyEpicVentilation() {

    apply_n() {

      for (i = [1:8]) {
        translate(v = [0, 35, i * 10 + 8])
        minkowski() {
          sphere(r=1);
          cube(size = [10, 40, 3]);
        }
      }

      children(0);
    }

  }
}


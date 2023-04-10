include <../helper/common.scad>
include <../helper/magnet.scad>


doorPolarityReference();

module doorPolarityReference() {
  thickness = 3;

  union() {
    difference() {
      minkowski() {
        cube(size = [50, 8, thickness]);
        cylinder(r = 2, h = eps);
      }

      union() {
        translate(v = [9, 0, 1.1])
        linear_extrude(2)
        text("D", font = "Liberation Sans:style=Bold", size = 8);

        translate(v=[31, 0, 1.1])
        linear_extrude(2)
        text("M",font="Liberation Sans:style=Bold", size=8);

      }
    }

    translate(v = [3.5, 4, thickness])
    magnetHolder();
    translate(v = [46.5, 4, thickness])
    magnetHolder();
  }

  module magnetHolder() {
    difference() {
      cylinder(r = magnetRSlacked+2, h = magnetHSlacked, $fn = 64);
      cylinder(r = magnetRSlacked, h = magnetHSlacked, $fn = 64);
    }
  }
}
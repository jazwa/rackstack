include <../helper/math.scad>
include <./config.scad>
include <./mainRail.scad>
include <./yBar.scad>
include <./xBar.scad>

translate(v=[12,2,18])
mainRail();

translate(v=[12,2 + 200,18])
mirror(v=[0,1,0])
*mainRail();

translate(v=[12 + 216,2,18])
mirror(v=[1,0,0])
*mainRail();

translate(v=[12 + 216,2 + 200,18])
rotate(a=[0,0,180])
*mainRail();

*xyPlane();

translate(v=[0,0,250])
mirror(v=[0,0,1])
*xyPlane();

module xyPlane() {
  yBar();

  translate(v = [240, 0, 0])
  mirror(v = [1, 0, 0])
  yBar();

  translate(v = [30, 0, 0])
  xBar();

  translate(v = [30, 206, 0])
  mirror(v = [0, 1, 0])
  xBar();
}

yBar();

translate(v = [30, 0, 0])
xBar();
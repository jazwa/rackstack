include <../helper/common.scad>
include <../helper/screws.scad>
include <./config.scad>

module basePlateMount() {

  screwHoleToBase = 6;
  mountHeight = 10;
  mountWidth = 10;
  mountThickness = 2;

  module support() {
    r = 4;

    difference () {
      translate(v = [0, mountThickness, r/2])
      rotate(a = [90, 0, 0])
      rotate(a = [0, 0, 90])
      cylinder(h = mountThickness, r = r, $fn = 3);

      cube(size=[inf10, inf10, inf10]);
    }

    //translate([-r/2, -2,0])
    //cube(size=[r/2, 0.1, 0.1]);
  }

  module positive() {
    cube(size = [mountWidth, mountThickness, mountHeight]);

    translate(v=[mountWidth,0,0])
    mirror(v=[1,0,0])
    hull() {
      support();
    }
  }

  module basePlateMount() {
    translate(v=[0,-mountThickness,0])
    difference() {
      positive();

      translate(v = [mountWidth/2, inf50/2, screwHoleToBase])
      rotate(a = [90, 0, 0])
      cylinder(h = inf50, r = screwRadiusSlacked(rackFrameScrewType));
    }
  }

  basePlateMount();

}



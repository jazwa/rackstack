
include <../config.scad>
include <./sideWallVariables.scad>
include <../sharedVariables.scad>
include <../../helper/halfspace.scad>
include <../../helper/magnet.scad>

module sideWallMagnetMount() {
  // oriented so that the xy face is the side wall's inner face
  difference() {
    cylinder(r1 = magnetMountShellRadius+1, r2 = magnetMountShellRadius, h = innerSideWallToYBarMagnetConn);

    translate(v=[0, 0, innerSideWallToYBarMagnetConn-magnetHSlacked])
    cylinder(r = magnetRSlacked, h = magnetHSlacked);
  }
}

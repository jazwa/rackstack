include <../yBar.scad>

include <../xBar.scad>

// Oriented for 3d printing.
// Supports required at XY wall connections, and depending on roundness
yBar();


*difference() {
  translate(v=[2,0,0])
  cube(size=[16,10,6], center=true);
  hexNutPocket_N("m3", openSide = false, backSpace = 5, bridgeFront = true);
}

*hexNutPocket_N("m3", openSide = false, backSpace = 5, bridgeBack = true);
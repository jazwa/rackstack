include <../yBar.scad>

include <../xBar.scad>

// Oriented for 3d printing.
// Supports required at XY wall connections, and depending on roundness
yBar();

translate(v=[140,0,0])
rotate(a=[0,0,90])
xBar();
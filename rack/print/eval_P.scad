include <../sharedVariables.scad>
use <../xBar.scad>
use <../yBar.scad>
use <../mainRail.scad>

// Evaluation print for slack config, please see rackstack/config/print.scad to configure tolerances
// Too tight -> increase slacks values. Too loose -> decrease values

intersection() {
  yBar();
  halfspace(vpos=[0,-1,0], p=[0,joinCornerDepth,0]);
}

translate(v=[35,0,0])
intersection() {
    translate(v=[0,-xBarX + xBarSideThickness + 5,0])
    xBar();
    halfspace(vpos=[0,1,0], p=[0,0,0]);
  }

translate(v=[35,18,0])
rotate(a=[0,0,90])
intersection() {
  mirror(v=[0,1,0])
  multmatrix(mainRailPrintOrientation)
  mainRail();
  halfspace(vpos=[-1,0,0], p=[19,0,0]);

  mainRailPrintOrientation = [
      [cos(-90), 0, sin(-90), railTotalHeight],
      [0, 1, 0, 0],
      [-sin(-90), 0, cos(-90), 0],
      [0, 0, 0, 1]
    ];
}
include <../xBar.scad>
include <../yBar.scad>
include <../mainRail.scad>


// Evaluation print for slack config

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

translate(v=[60,20,0])
rotate(a=[0,0,90])
intersection() {
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
include <../sharedVariables.scad>

use <../mainRail.scad>

// Oriented for 3d printing.
// Supports not required.
multmatrix(mainRailPrintOrientation)
mainRail();

mainRailPrintOrientation = [
    [cos(-90),  0, sin(-90), railTotalHeight],
    [0,         1, 0,        0              ],
    [-sin(-90), 0, cos(-90), 0              ],
    [0,         0, 0,        1              ]
  ];
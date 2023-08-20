include <./common.scad>

// OpenSCAD script to output some helpful dimensions for creating new rack-mount items:

echo("Vertical distance between 2 main rail holes: ", screwDiff);
echo("Horizontal distance between 2 opposing main rail holes: ", rackMountScrewWidth);

echo("Max supported rack-mount width: ", maxUnitWidth);
echo("Max recommended rack-mount depth: ", maxUnitDepth);


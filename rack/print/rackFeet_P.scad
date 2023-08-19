include <../sharedVariables.scad>
use <../stackEnds.scad>


// Oriented for 3d printing. No supports required.
rotate(a=[90-feetProtrusionAngle,0,0])
rackFeet();
/*
   case-files v2
   This file contains parameters used for declaring/generating a customized rack frame.

   - All dimensions are in millimetres (mm) unless stated otherwise.
   - A "_N" appended to a module is meant to denote that this module is a negative volume, and should only be used to
     substract from other volumes.
*/

// Maximum width for rackmount units. Change this according your max expected enclosure width.
// Changing this will directly affect the required build volume.
maxUnitWidth = 200;

// Maximum (recommended) unit depth. There technically isn't a max unit depth because there's no physical bound on
// how far a rack unit can extrude back. This parameter basically controls the distance between the front of the front
// rails and the back of the back rails. Changing this will directly affect the required build volume.
maxUnitDepth = 200;

// Vertical distance between the midpoint of adjacent screws mounts. Affects build volume.
screwDiff = 10;

// Number screw slots on the main rail. Affects build volume.
numRailScrews = 20;

// Screw type used for rackmount units. See screws.scad.
railMainScrewType = "m4";

// Screw type used to affix side rails.
railSideMountScrewType = "m4";

// Screw type used for constructing the actual rack frame.
rackScrewType = "m3";

/*
   case-files v2
   This file contains parameters used for declaring/generating a customized rack frame.

   - All dimensions are in millimetres (mm) unless stated otherwise.
   - "_N" appended to a module is meant to denote that this module is a negative volume, and should only be used to
     substract from other volumes. "_P" is meant to denote a positive value. Modules are positive by default.
*/
include <./profiles.scad>

profileName = "micro";
profile = getProfile(profileName);

echo("Profile:", profile);

function getConfig(name) = getConfigValue(profile, name);

// Maximum width for rackmount units. Change this according your max expected enclosure width.
// Changing this will directly affect the required build volume.
maxUnitWidth = getConfig("maxUnitWidth");

// Maximum (recommended) unit depth. There technically isn't a max unit depth because there's no physical bound on
// how far a rack unit can extrude back. This parameter basically controls the distance between the front of the front
// rails and the back of the back rails. Changing this will directly affect the required build volume.
maxUnitDepth = getConfig("maxUnitDepth");

// Vertical distance between the midpoint of adjacent screws mounts. Affects build volume.
screwDiff = getConfig("screwDiff");

// Number screw slots on the main rail. Affects build volume.
numRailScrews = getConfig("numRailScrews");

// Screw type used for rackmount units. See screws.scad.
mainRailScrewType = getConfig("mainRailScrewType");

// Screw type used to affix side rails.
mainRailSideMountScrewType = getConfig("mainRailSideMountScrewType");

// Screw type used for constructing the actual rack frame.
rackFrameScrewType = getConfig("rackFrameScrewType");
// Currently, only m3 screws are supported here (tolerance issues)
assert(rackFrameScrewType == "m3");

// Fillet radius for main rack profile
baseRoundness = getConfig("baseRoundness");

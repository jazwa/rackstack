// Manually set this variable to toggle rack profile
profileName = "default";

fixedSideModules = true;

_profileConfigs = [
    // You can introduce a custom profile like:
    /*
    ["custom", [
      ["maxUnitWidth", 180],
      ["maxUnitDepth", 120],
      ["numRailScrews", 10]
    ]], // To generate the stls for this custom profile, you would do:
        // $ python3 rbuild.py -b all -c custom
    */
    ["default", [ // Default config. Will be overwritten by any other profiles
      ["maxUnitWidth", 180],
      ["maxUnitDepth", 180],
      ["numRailScrews", 12],
      ["screwDiff", 10],
      ["mainRailScrewType", "m4"],
      ["mainRailSideMountScrewType", "m4"],
      ["rackFrameScrewType", "m3"],
      ["baseRoundness", 5],
    ]],
    ["nano", [
      ["maxUnitWidth", 105],
      ["maxUnitDepth", 105],
      ["numRailScrews", 10]
    ]],
    ["micro", [
      ["maxUnitWidth", 180],
      ["maxUnitDepth", 180],
      ["numRailScrews", 12]
    ]],
    ["mini", [
      ["maxUnitWidth", 205],
      ["maxUnitDepth", 205],
      ["numRailScrews", 16]
    ]]
  ];

function _getConfigValueRaw(profile, varName) = profile[search([varName], profile)[0]][1];
function _getProfileRaw(profileName) = _profileConfigs[search([profileName], _profileConfigs)[0]][1];

function _getConfigValueOrThrowError(val) = val == undef? assert(false, "blah") 0: val;
function _getConfigValueOrDefault(val, default) = val == undef? default: val;

function getConfigValue(profile, varName) =
_getConfigValueOrDefault(
_getConfigValueRaw(profile, varName),
_getConfigValueOrThrowError(_getConfigValueRaw(getProfile("default"), varName))
);

function getProfile(profileName) = _getConfigValueOrThrowError(_getProfileRaw(profileName));

function getConfig(name) = getConfigValue(profile, name);

profile = getProfile(profileName);

// Maximum width for rack-mount units. Change this according your max expected enclosure width.
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

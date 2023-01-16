/*
    case-files v2
    This file contains
    Example usage:

 profileName = "mini";
 varName = "mainRailSideMountScrewType";

 profile = getProfile(profileName);
 echo("val:", getConfigValue(profile, varName));
 */

_profileConfigs = [
    ["default", [
      ["maxUnitWidth", 205],
      ["maxUnitDepth", 205],
      ["screwDiff", 10],
      ["numRailScrews", 20],
      ["mainRailScrewType", "m4"],
      ["mainRailSideMountScrewType", "m4"],
      ["rackFrameScrewType", "m3"],
      ["baseRoundness", 5],
    ]],
    ["micro", [
      ["maxUnitWidth", 105],
      ["maxUnitDepth", 105],
      ["numRailScrews", 10],
      ["baseRoundness", 5]
    ]],
    ["mini", [
      ["maxUnitWidth", 205],
      ["maxUnitDepth", 205],
      ["numRailScrews", 20],
      ["baseRoundness", 5]
    ]]
  ];

function _getConfigValueRaw(profile, varName) = profile[search([varName], profile)[0]][1];
function _getProfileRaw(profileName) = _profileConfigs[search([profileName], _profileConfigs)[0]][1];

function _getConfigValueOrThrowError(val) = val == undef? assert(false, "blah") 0: val;

function getConfigValue(profile, varName) = _getConfigValueOrThrowError(_getConfigValueRaw(profile, varName));
function getProfile(profileName) = _getConfigValueOrThrowError(_getProfileRaw(profileName));

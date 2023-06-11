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
      ["maxUnitWidth", 170],
      ["maxUnitDepth", 180],
      ["numRailScrews", 18],
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
      ["maxUnitWidth", 170],
      ["maxUnitDepth", 180],
      ["numRailScrews", 18]
    ]],
    ["mini", [
      ["maxUnitWidth", 205],
      ["maxUnitDepth", 205],
      ["numRailScrews", 20]
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

use <./tray.scad>

/*
  Parametric rack-mount tray:
  Dimensions can be adjusted using the variables below. You can also add mounting holes to fasten things that have
  screw holes at the bottom.

  !!! Please also make sure that the correct rack frame preset is set in rackFrame.scad !!!
*/

module traySystem (

// begin config ////////////////////////////////////////////////////////////////////////////////////////////////////////

trayU = 2,

baseWidth = 145,
baseDepth = 100,

baseThickness = 3, // tray bottom thickness
frontThickness = 3, // front plate thickness
sideThickness = 3,

backLipHeight = 2,
frontLipHeight = 2,

sideSupport = true,
trayLeftPadding = 10, // extra space between the left rail and tray. configure this to move the tray left/right.

mountPointType = "m3",
mountPointElevation = 1, // basically standoff height

// add/config standoff coordinates here. Format is [[x,y]]
mountPoints = [
    [30,10],
    [30+75,10],
    [30,10+75],
    [30+75,10+75],
]

// end config //////////////////////////////////////////////////////////////////////////////////////////////////////////

) {

  bottomScrewTray (
    u = trayU,
    trayWidth = baseWidth,
    trayDepth = baseDepth,
    trayThickness = baseThickness,
    frontLipHeight = frontLipHeight,
    backLipHeight = backLipHeight,
    mountPoints = mountPoints,
    frontThickness = frontThickness,
    sideThickness = sideThickness,
    mountPointElevation = mountPointElevation,
    mountPointType = mountPointType,
    sideSupport = sideSupport,
    trayLeftPadding = trayLeftPadding
  );
}

traySystem();

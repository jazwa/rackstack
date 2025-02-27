use <./tray.scad>

/*
  Parametric rack-mount tray:
  Dimensions can be adjusted using the variables below. You can also add mounting holes to fasten things that have
  screw holes at the bottom.

  !!! Please also make sure that the correct rack frame preset is set in rackFrame.scad !!!
*/

/* [Tray Basic Dimensions] */
// Height of the tray in rack units (U)
trayU = 2; // [1:0.5:4]

// Total base width including padding (mm)
baseWidth = 145; // [100:1:200]

// Total depth of the tray (mm)
baseDepth = 100; // [50:1:300]

/* [Thickness Settings] */
// Thickness of tray bottom (mm)
baseThickness = 3; // [1:0.5:5]

// Thickness of front plate (mm)
frontThickness = 3; // [1:0.5:5]

// Thickness of side walls (mm)
sideThickness = 3; // [1:0.5:5]

/* [Lip Settings] */
// Height of back lip (mm)
backLipHeight = 2; // [0:0.5:10]

// Height of front lip (mm)
frontLipHeight = 2; // [0:0.5:10]

/* [Support Settings] */
// Enable side support
sideSupport = true;

// Extra space between left rail and tray (mm)
trayLeftPadding = 10; // [0:1:50]

/* [Mount Point Settings] */
// Type of mounting holes
mountPointType = "m3"; // [m3:M3, m4:M4, m5:M5]

// Standoff height for mounting points (mm)
mountPointElevation = 1; // [0:0.5:5]

/* [Mount Points] */
// Enable mount points
enableMountPoints = true;
// First mount point X coordinate
mp1x = 30; // [0:1:200]
// First mount point Y coordinate
mp1y = 10; // [0:1:200]
// Second mount point X coordinate
mp2x = 105; // [0:1:200]
// Second mount point Y coordinate
mp2y = 10; // [0:1:200]
// Third mount point X coordinate
mp3x = 30; // [0:1:200]
// Third mount point Y coordinate
mp3y = 85; // [0:1:200]
// Fourth mount point X coordinate
mp4x = 105; // [0:1:200]
// Fourth mount point Y coordinate
mp4y = 85; // [0:1:200]

// Mount point coordinates
mountPoints = enableMountPoints ? [
  [mp1x, mp1y],
  [mp2x, mp2y],
  [mp3x, mp3y],
  [mp4x, mp4y],
] : [];

module traySystem() {
  bottomScrewTray(
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

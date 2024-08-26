use <../tray/tray.scad>

/*
  Simple tray for a mele quieter series mini pc.

  Please make sure to configure the correct rack frame dimensions in rackFrame.scad.
*/

bottomScrewTray (
    u = 2,
    trayWidth = 145,
    trayDepth = 88,
    trayThickness = 3,
    frontLipHeight = 3,
    backLipHeight = 2,
    mountPoints = [[27.5, 34], [107, 34]],
    frontThickness = 3,
    sideThickness = 3,
    mountPointElevation = 1,
    mountPointType = "m3",
    sideSupport = true,
    trayLeftPadding = 10
);

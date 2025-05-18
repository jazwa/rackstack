use <../tray/tray.scad>

/*
  Simple tray for a LG Slim Portable DVD Writer.

  Please make sure to configure the correct rack frame dimensions in rackFrame.scad.
  
  Remember to use Velcro strips to secure the drive to the tray!
*/

bottomScrewTray (
    u = 1,
    trayWidth = 150,
    trayDepth = 145,
    trayThickness = 3,
    frontLipHeight = 0,
    backLipHeight = 0,
//    mountPoints = [[27.5, 34], [107, 34]],
    frontThickness = 3,
    sideThickness = 3,
    mountPointElevation = 1,
    mountPointType = "m3",
    sideSupport = true,
    trayLeftPadding = 15
);

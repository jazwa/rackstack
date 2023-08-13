use <../tray.scad>

// Config variables
trayWidth = 140;
trayDepth = 88;
trayThickness = 3;
trayLipThickness = 3;

pointHoleRadius = screwRadiusSlacked("m3");
pointHoleThickness = 2;
pointMountElevation = 1;
mountPoints = [ // [x,y,elevation,holeRadius,holeThickness]
   [(27.5),34, pointMountElevation, pointHoleRadius, pointHoleThickness],
   [(27.5)+79.5,34, pointMountElevation, pointHoleRadius, pointHoleThickness]
];

mountScrewType = "m3";

// Rack mount tray that supports screws on the bottom of the rack-mount item
bottomScrewTray(u=1, trayWidth=trayWidth, trayDepth=trayDepth, trayThickness=trayThickness, mountPoints=mountPoints, mountScrewType=mountScrewType, lipThickness=trayLipThickness);
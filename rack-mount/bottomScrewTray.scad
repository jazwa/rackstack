include <./common.scad>
use <./rackEars.scad>

// Rack mount tray that supports screws on the bottom of the rack-mount item

// Config variables
//trayAlignment = "middle"; // middle, right, left
trayWidth = 150;
trayDepth = 100;
trayThickness = 3;

mountPoints = [];
mountScrewType = "m3";


bottomScrewTray(u=5);

module bottomScrewTray(u) {

  screwDx = rackMountScrewWidth;
  echo(screwDx);
  screwDz = uDiff * u;

  plateLength = screwDx + 2*rackMountScrewXDist;
  plateHeight = screwDz + 2*rackMountScrewZDist;

  leftScrewDistToTray = 10+4+3;
  assert(leftScrewDistToTray >= 5);

  leftScrewGlobalX = -leftScrewDistToTray;
  rightScrewGlobalX = screwDx + leftScrewGlobalX;

  cube(size=[trayWidth, trayDepth, trayThickness]);

  translate(v=[rackMountScrewXDist+leftScrewGlobalX+3,0,rackMountScrewZDist])
  rackEarModule(frontThickness=3,sideThickness=3,frontWidth=leftScrewDistToTray, sideDepth=trayDepth-3, u=5);

  translate(v=[rightScrewGlobalX,0,rackMountScrewZDist])
  mirror(v=[1,0,0])
  rackEarModule(frontThickness=3,sideThickness=3,frontWidth=30, sideDepth=trayDepth-3, u=5);

}
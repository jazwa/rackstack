include <./common.scad>
use <./rackEars.scad>

// Rack mount tray that supports screws on the bottom of the rack-mount item

// Config variables
//trayAlignment = "middle"; // middle, right, left
trayWidth = 110;
trayDepth = 100;
trayThickness = 3;

mountPoints = [];
mountScrewType = "m3";


bottomScrewTray(u=5);

module bottomScrewTray(u) {


  frontLipHeight = 5;
  backLipHeight = 5; // also applies to sides
  lipThickness = 3;

  rackEarSideThickness = 3;
  rackEarFrontThickness = 3;

  screwDx = rackMountScrewWidth; // x dist between the mount holes
  screwDz = uDiff * u;

  plateLength = screwDx + 2*rackMountScrewXDist;
  plateHeight = screwDz + 2*rackMountScrewZDist;

  minScrewToTraySpacing = 8;

  // TODO: toggle this based on left/right/middle alignment
  leftScrewDistToTray = minScrewToTraySpacing + 2 +5;

  leftScrewGlobalX = -leftScrewDistToTray;
  rightScrewGlobalX = screwDx + leftScrewGlobalX;

  cube(size=[trayWidth, trayDepth, trayThickness]);

  translate(v=[0,0,trayThickness])
  cube(size=[trayWidth, lipThickness, frontLipHeight]);

  translate(v=[0,trayDepth-lipThickness,trayThickness])
  cube(size=[trayWidth, lipThickness, backLipHeight]);

  translate(v=[0,0,trayThickness])
  cube(size=[lipThickness, trayDepth, backLipHeight]);

  translate(v=[trayWidth-lipThickness,0,trayThickness])
  cube(size=[lipThickness, trayDepth, backLipHeight]);

  translate(v=[leftScrewGlobalX,0,rackMountScrewZDist])
  rackEarModule(frontThickness=rackEarFrontThickness,sideThickness=rackEarSideThickness,frontWidth=leftScrewDistToTray+rackMountScrewXDist+rackEarSideThickness, sideDepth=trayDepth-lipThickness, u=u);

  translate(v=[rightScrewGlobalX,0,rackMountScrewZDist])
  mirror(v=[1,0,0])
  rackEarModule(frontThickness=rackEarFrontThickness,sideThickness=rackEarSideThickness,frontWidth=rightScrewGlobalX-trayWidth+rackMountScrewXDist+rackEarSideThickness, sideDepth=trayDepth-lipThickness, u=u);

}
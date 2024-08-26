include <../common.scad>
use <../rackEars.scad>

/*
  Parametric rack-mount tray -
  Please see ./entry.scad for configuring/printing

  Please also make sure that the correct rack frame preset is set in rackFrame.scad.
*/

module bottomScrewTray(u, trayWidth, trayDepth, trayThickness, mountPoints, mountPointElevation, mountPointType, frontThickness, sideThickness, frontLipHeight, backLipHeight, trayLeftPadding, sideSupport=true) {

  lipThickness = sideThickness;

  screwDx = rackMountScrewWidth; // x dist between the mount holes
  screwDz = uDiff * u;

  plateLength = screwDx + 2*rackMountScrewXDist;
  plateHeight = screwDz + 2*rackMountScrewZDist;

  minScrewToTraySpacing = railScrewHoleToInnerEdge;

  leftScrewDistToTray = minScrewToTraySpacing + trayLeftPadding;

  leftScrewGlobalX = -leftScrewDistToTray;
  rightScrewGlobalX = screwDx + leftScrewGlobalX;

  // check (tray width)+(configured extra space) fits within the rack
  assert(trayWidth <= screwDx-(2*minScrewToTraySpacing + trayLeftPadding));

  difference() {
    applyMountHoles()
    translate(v = [-sideThickness, -frontThickness, -trayThickness])
    body();
  }

  module body() {

    // base
    cube(size = [trayWidth, trayDepth, trayThickness]);

    // front lip
    translate(v = [0, 0, trayThickness])
    cube(size = [trayWidth, lipThickness, frontLipHeight]);

    // back lip
    translate(v = [0, trayDepth-lipThickness, trayThickness])
    cube(size = [trayWidth, lipThickness, backLipHeight]);

    translate(v = [leftScrewGlobalX, 0, rackMountScrewZDist])
    rackEarModule(frontThickness = frontThickness, sideThickness = sideThickness, frontWidth =
        leftScrewDistToTray+rackMountScrewXDist+sideThickness, sideDepth = trayDepth-lipThickness, u = u, backPlaneHeight=trayThickness+backLipHeight, support=sideSupport);

    translate(v = [rightScrewGlobalX, 0, rackMountScrewZDist])
    mirror(v = [1, 0, 0])
    rackEarModule(frontThickness = frontThickness, sideThickness = sideThickness, frontWidth =
       rightScrewGlobalX-trayWidth+rackMountScrewXDist+sideThickness, sideDepth = trayDepth-lipThickness, u = u, backPlaneHeight=trayThickness+backLipHeight, support=sideSupport);
    }


  module applyMountHoles() {

    mountPointPosThickness = 2;

    if (len(mountPoints) > 0) {
      apply_pn() {
        for (i = [0:len(mountPoints)-1]) {
          x = mountPoints[i][0];
          y = mountPoints[i][1];

          translate(v = [x, y, 0])
          cylinder(r = screwRadiusSlacked(mountPointType)+mountPointPosThickness, h = mountPointElevation);
        }

        for (i = [0:len(mountPoints)-1]) {
          x = mountPoints[i][0];
          y = mountPoints[i][1];

          translate(v = [x, y, -trayThickness])
          mirror(v = [0, 0, 1])
          counterSunkHead_N(mountPointType, inf, inf);
        }

        children(0);
      }
    } else {
      children(0);
    }

  }


}

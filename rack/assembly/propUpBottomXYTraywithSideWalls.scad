include <./common.scad>
use <./insertDowelsIntoSideWall.scad>
use <./connectXYTrayWithMainRails.scad>

$vpt = [96,110,70];
$vpr = [68,0,36];
$vpd = 700;
$vpf = 22.50;

propUpBottomXYTraywithSideWalls(at=$t, r=0);

module propUpBottomXYTraywithSideWalls(at=0, r=0) {

  t = lerp(a=10,b=0,t=at);

  function sideWallToYBarTrans(t=0,r=0) =
    yBarMirrorOtherCornerTrans *
    yBarSideModuleConnectorTrans * // bring to y bar space
    mirror(v=[0,1,0]) *
    translate(v=[0,0,t]) *
    translate(v=[sideWallConnW/2.0, -hingePoleR, sideWallZHingeTotalClearance]) * // bring to side module space
    rotate(a=[0,0,-r]) *
    translate(v=[-hingePoleDx, -hingePoleDy, 0]);

  connectXYTrayWithMainRails(at=1);

  multmatrix(sideWallToYBarTrans(t=t, r=r))
    insertDowelsIntoSideWall(at=1);

  multmatrix(xBarSpaceToYBarSpace * xBarMirrorOtherCornerTrans * yBarSpaceToXBarSpace * sideWallToYBarTrans(t=t,r=r))
    insertDowelsIntoSideWall(at=1);
}
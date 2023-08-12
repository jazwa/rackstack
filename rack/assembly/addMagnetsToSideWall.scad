include <./common.scad>

$vpt = [23,105,70];
$vpr = [84,0,133];
$vpd = 370;
$vpf = 22.50;

addMagnetsToSideWall(at=$t);

module addMagnetsToSideWall(at=0) {
  t = lerp(a=8,b=0,t=at);

  if (!plasticMask) {
    sideWallLeft();
  }

  function insertMagnetTrans(t=0) =
    translate(v=[sideWallThickness+t, magnetMountToYBarFront, magnetMountToYBarTop-sideWallZHingeTotalClearance]) *
    rotate(a=[0,90,0]);

  multmatrix(insertMagnetTrans(t=t))
    magnet();

  multmatrix(translate(v=[0,0,sideWallZ - 2*(magnetMountToYBarTop- sideWallZHingeTotalClearance)]) * insertMagnetTrans(t=t))
    magnet();
}
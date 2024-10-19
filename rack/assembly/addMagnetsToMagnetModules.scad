include <./common.scad>
use <./slideHexNutsIntoYBar.scad>

$vpt = [21,-15,20];
$vpr = [65,0,40];
$vpd = 50;
$vpf = 22.50;

addMagnetsToMagnetModules(at=$t);

module addMagnetsToMagnetModules(at=0) {
  t = lerp(a=6,b=0,t=at);

  
  if (!plasticMask) {

      if (fixedSideModules) {
          multmatrix(yBarToMagnetModuleTrans)
          slideHexNutsIntoYBar(at=1);
      }
      else {
          magnetModule();
      }
  }

  function insertMagnetTrans(t=0) =
    translate(v=[sideWallConnW-(magnetFaceToSideWallConnOuterYEdge+magnetHSlacked) + t,
      magnetModuleMagnetMountDy,
      magnetModuleMagnetMountDz]) *
    rotate(a=[0,90,0]);



   multmatrix(insertMagnetTrans(t=t))
     magnet();

}

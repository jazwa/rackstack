include <./common.scad>

$vpt = [43,66,41];
$vpr = [44,0,47];
$vpd = 350;
$vpf = 22.50;

slideHexNutsIntoYBar(at=$t);

module slideHexNutsIntoYBar(at=0)
{

  t = lerp(a=20,b=0,t=at);

  if (!plasticMask) {
    yBar();
  }

  function sideModuleTrans(t=0) =
      yBarSideModuleConnectorTrans *
      translate(v = [yBarScrewHoleToOuterYEdge, yBarScrewHoleToFrontXEdge+t, -(4+sideWallConnLugDepression)]) *
    rotate(a=[0,0,90]);

  function mainRailTrans(t=0) =
      yBarMainRailConnectorTrans *
      translate(v = [mainRailSlideHexOnYBarDx+t, mainRailSlideHexOnYBarDy, -5]) *
    rotate(a=[-45,0,0]);

  function xBarTrans(t=0) =
      translate(v = [-5, 27, 8+t]) *
      yBarXBarConnectorTrans *
    rotate(a=[0,90,0]);

  module slideHexNutsOneCorner(t=0) {

      if (!fixedSideModules) {
          multmatrix(sideModuleTrans(t = t))
              hexNut(rackFrameScrewType);
      }

    multmatrix(mainRailTrans(t = t))
      hexNut(rackFrameScrewType);

    multmatrix(xBarTrans(t = t))
      hexNut(rackFrameScrewType);
  }

  if (!screwMask) {
    slideHexNutsOneCorner(t = t);

    multmatrix(yBarMirrorOtherCornerTrans)
      slideHexNutsOneCorner(t = t);
  }

}

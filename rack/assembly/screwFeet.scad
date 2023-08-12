include <./common.scad>
use <./insertFeet.scad>

$vpt = [95,90,10];
$vpr = [105,0,38];
$vpd = 650;
$vpf = 22.50;

screwFeet(at=$t);

module screwFeet(at=0,r=0) {

  t = lerp(a=20, b=0, t=at);

  function screwTrans(t=0) = translate(v=[-t - 9,0,connectorBottomToScrew]) * rotate(a=[0,-90,0]);
  mirrorOtherFeetStackConnectorTrans = translate(v=[stackConnectorDx,0,0]) * mirror(v=[1,0,0]);


  module screwToFeetModule() {
    multmatrix(feetToYBarTrans(t = 0)*screwTrans(t = t))
      caseScrewMedium();

    multmatrix(feetToYBarTrans(t = 0)*mirrorOtherFeetStackConnectorTrans*screwTrans(t = t))
      caseScrewMedium();
  }

  screwToFeetModule();

  multmatrix(yBarMirrorOtherCornerTrans)
    screwToFeetModule();

  insertFeet(at=1,r=r);
}

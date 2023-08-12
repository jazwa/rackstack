include <./common.scad>
use <./slideHexNutToFeet.scad>
use <./attachXYPlates.scad>

$vpt = [95,90,10];
$vpr = [105,0,38];
$vpd = 650;
$vpf = 22.50;

insertFeet(at=$t);

module insertFeet(at=0,r=0) {

  t = lerp(a=10,b=0,t=at);

  attachXYPlates(at=1,r=r);

  multmatrix(feetToYBarTrans(t=t))
    slideHexNutToFeet(at=1);

  multmatrix(yBarMirrorOtherCornerTrans * feetToYBarTrans(t=t))
    slideHexNutToFeet(at=1);
}

module screwFeet(at=0,r=0) {

  t = lerp(a=20, b=0, t=at);

  function screwTrans(t=0) = translate(v=[-t - 9,0,connectorBottomToScrew]) * rotate(a=[0,-90,0]);
  mirrorOtherFeetStackConnectorTrans = translate(v=[stackConnectorDx,0,0]) * mirror(v=[1,0,0]);


  module screwToFeetModule() {
    multmatrix(feetToYBarTrans(t = 0)*screwTrans(t = t))
      caseScrewLong(); // we might want a longer screw?

    multmatrix(feetToYBarTrans(t = 0)*mirrorOtherFeetStackConnectorTrans*screwTrans(t = t))
      caseScrewLong();
  }

  screwToFeetModule();

  multmatrix(yBarMirrorOtherCornerTrans)
    screwToFeetModule();

  insertFeet(at=1,r=r);
}

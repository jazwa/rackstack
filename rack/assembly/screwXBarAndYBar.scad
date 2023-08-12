include <./common.scad>
use <./attachXBarWithYBar.scad>

$vpt = [103,90,20];
$vpr = [68,0,36];
$vpd = 500;
$vpf = 22.50;

screwXBarAndYBar(at=$t);

module screwXBarAndYBar(at=0) {
  screwExtension = lerp(a=16, b=0, t=at);

  // in x bar space
  function xBarYBarScrewTrans(extension) =
    translate(v=[27,xBarSideThickness + extension,8]) * rotate(a=[270,0,0]);

  attachXBarWithYBar(at=1);

  multmatrix(xBarSpaceToYBarSpace)
    union() {

      if (!plasticMask) { xBar(); }

      multmatrix(xBarYBarScrewTrans(screwExtension))
        caseScrewLong();

      multmatrix(xBarMirrorOtherCornerTrans * xBarYBarScrewTrans(screwExtension))
        caseScrewLong();
    }

  multmatrix(yBarMirrorOtherCornerTrans*xBarSpaceToYBarSpace)
    union() {
      if (!plasticMask) { xBar(); }

      multmatrix(xBarYBarScrewTrans(screwExtension))
        caseScrewLong();

      multmatrix(xBarMirrorOtherCornerTrans * xBarYBarScrewTrans(screwExtension))
        caseScrewLong();
    }
}
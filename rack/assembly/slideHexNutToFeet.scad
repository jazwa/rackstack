include <./common.scad>

$vpt = [75,-10,-14];
$vpr = [74,0,120];
$vpd = 300;
$vpf = 22.50;

slideHexNutToFeet(at=$t);

module slideHexNutToFeet(at=0) {

  t = lerp(a=8, b=0, t=at);

  module slideNut() {
    if (!screwMask) {
      rotate(a = [0, 0, 90])
        rotate(a = [90, 0, 0])
          hexNut(rackFrameScrewType);
    }
  }

  translate(v=[0,t,connectorBottomToScrew + 0.5]) // where does this come from again? slack?
    slideNut();

  translate(v=[stackConnectorDx,t,connectorBottomToScrew + 0.5]) // where does this come from again? slack?
    slideNut();

  if (!plasticMask) {
    rackFeet();
  }
}

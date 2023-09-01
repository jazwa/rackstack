include <../common.scad>
use <./entry.scad>

$vpt = [110,-42,36];
$vpr = [77,0,23];
$vpd = 445;
$vpf = 22.50;

animatePatchPanel(at=$t);

module animatePatchPanel(at=$t) {

  plateThickness = 3;
  keystoneSpacing = 19;
  slots = max(1,ceil(at*8));

  rotate(a=[90,0,0])
  mirror(v=[0,0,1])
  render()
  patchPanelSystem(numSlots = slots, plateThickness=plateThickness, keystoneSpacing=keystoneSpacing);

  // keystone visualization
  for (i = [0:slots-1]) {
    translate(v=[keystoneSpacing*i + 12, 0,0,]) // hardcoded offset
    %rj45Keystone();
  }

}
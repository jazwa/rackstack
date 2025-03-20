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
  allSlots = [2, 2, 2, 2, 2, 2, 2, 5, 2];
  numSlots = max(1,ceil(at*8));
  slots = [each [for (i=[1:numSlots]) allSlots[i]]];

  rotate(a=[90,0,0])
  render()
  patchPanelSystem(slots = slots, plateThickness=plateThickness, keystoneSpacing=keystoneSpacing);

}
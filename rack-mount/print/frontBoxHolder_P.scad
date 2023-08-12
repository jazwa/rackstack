include <../../rack/sharedVariables.scad>
use <../frontBoxHolder.scad>

frontBoxHolder(
  u=2,
  plateThickness=3,
  cutoutOffsetX=(rackMountScrewWidth-147)/2,
  cutoutOffsetY=4.25,
  cutoutX=147,
  cutoutY=21.5,
  support=true,
  supportedZ = 26.5,
  supportWidth=120,
  supportDepth=5,
  supportRailBaseThickness=1.75
);

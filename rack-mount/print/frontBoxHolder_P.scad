include <../../rack/sharedVariables.scad>
use <../frontBoxHolder.scad>

frontBoxHolder(
  u=2,
  plateThickness=3,
  cutoutOffsetX=(rackMountScrewWidth-147)/2,
  cutoutOffsetY=2,
  cutoutX=147,
  cutoutY=26,
  support=true,
  supportedZ = 27.5,
  supportWidth=120,
  supportDepth=5,
  supportRailBaseThickness=1.25
);

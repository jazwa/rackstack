include <../common.scad>
use <./entry.scad>

$vpt = [100,-42,36];
$vpr = [70,0,27];
$vpd = 445;
$vpf = 22.50;

animateTraySystem(at=$t);

module animateTraySystem(at=$t) {

  trayU = max(1, ceil(at*3));
  x=100;
  y=100;
  dx = abs(lerp(a=-40, b=40, t=at));
  dy = abs(lerp(a=-30, b=30, t=at));

  traySystem(trayU=trayU, baseWidth=x+dx, baseDepth=y+dy, mountPoints=[], backLipHeight=8);
}
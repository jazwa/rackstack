use <./entry.scad>

$vpt = [120,-30,63];
$vpr = [74,0,25];
$vpd = 550;
$vpf = 22.50;

animateEnclosedBoxSystem(at=$t);

module animateEnclosedBoxSystem(at=$t) {

  zOrientation = "middle";
  x=150;
  y=70;
  z=20;
  dx = abs(lerp(a=-20, b=20, t=at));
  dy = abs(lerp(a=-50, b=50, t=at));
  dz = abs(lerp(a=-15, b=15, t=at));

  enclosedBoxSystem(visualize=true, zOrientation=zOrientation, boxWidth=x+dx, boxDepth=y+dy, boxHeight=z+dz);
}

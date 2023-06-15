include <../helper/screws.scad>
include <../helper/magnet.scad>
include <../helper/dowel.scad>

$vpr=[85,0,25];
//$vpd=40;
$vpd=30;
//$vpd=25;
$vpf=20;


glue(tilt=15,r=360*$t);
//m3FHCS(length=8,tilt=45,r=360*$t);
// magnet(tilt=90, r=360*$t);
// hingeDowel(tilt=90,r=360*$t);
// m3Hex(tilt=90,r=360*$t);

metalColor = [0.8,0.8,0.8];

module m3FHCS(length, tilt, r) {
  rotate(a=[0,0,r])
  rotate(a=[tilt,0,0])
  translate(v=[0,0,length/2])
  color(metalColor) {
    difference() {
      counterSunkHead_N("m3", screwExtension = length-m3CounterSunkHeadLength, headExtension = 0.5);
      cylinder($fn = 6, r = 1.2);
    }
  }
}

module m3Hex(tilt, r) {

  rotate(a=[0,0,r])
  rotate(a=[tilt,0,0])
  color(metalColor)
  hexNut("m3");
}

module hingeDowel(tilt, r) {
  rotate(a=[0,0,r])
  rotate(a=[tilt,0,0])
  translate(v=[0,0,-dowelPinH/2])
  color(metalColor)
  cylinder(h = dowelPinH, r = dowelPinR);
}


module magnet(tilt, r) {
  rotate(a=[0,0,r])
  rotate(a=[tilt,0,0])
  translate(v=[0,0,-magnetH/2])
  color(metalColor)
  cylinder(r = magnetR, h = magnetH);
}

module glue(tilt,r) {

  rotate(a=[0,0,r])
  rotate(a=[0,tilt,0])

  union() {
    // cap
    color([0.3,0.3,1])
    translate(v = [0, 0, 4])
    union() {
      cylinder(r1 = 0.8, r2 = 0.6, h = 2);

      gills = 8;
      for (i = [0:gills]) {
        translate(v = [0, 0, -0.1])
        rotate(a = [0, 0, 360/gills*i])
        rotate(a = [0, -6.5, 0])
        cube(size = [0.9, 0.1, 2]);
      }
    }

    // body
    color([0.9,0.5,0.1])
    hull() {
      translate(v = [0, 0, 4])
      cylinder(r = 0.4, h = 0.1);

      translate(v = [0, 0, 3])
      scale(v = [1.2, 1, 1])
      cylinder(r = 1, h = 0.1);

      scale(v = [1.5, 1, 1])
      cylinder(r = 1, h = 0.1);
      translate(v = [0, 0, -3])
      cube(size = [4, 0.2, 0.1], center = true);
    }
  }
}


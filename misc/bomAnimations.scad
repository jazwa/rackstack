include <../helper/screws.scad>
include <../helper/magnet.scad>
include <../helper/dowel.scad>

$vpr=[85,0,25];
//$vpd=40;
//$vpd=30;
$vpd=25;
$vpf=20;



//m3FHCS(length=8,tilt=45,r=360*$t);
 magnet(tilt=90, r=360*$t);
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
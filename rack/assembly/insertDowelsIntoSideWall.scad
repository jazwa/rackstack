include <./common.scad>
use <./addMagnetsToSideWall.scad>

$vpt = [65,120,96];
$vpr = [66,0,112];
$vpd = 500;
$vpf = 22.50;

insertDowelsIntoSideWall(at=$t);

module insertDowelsIntoSideWall(at=0) {

  t = lerp(a=10, b=0, t=at);

  hingeHoleH = hingePoleH-sideWallConnLugDepression;

  addMagnetsToSideWall(at=1);

  translate(v=[hingePoleDx,hingePoleDy, (sideWallZ-hingeHoleH) + t])
    hingeDowel();

  translate(v=[hingePoleDx,hingePoleDy, (hingeHoleH-hingePoleH)-t])
    hingeDowel();

}
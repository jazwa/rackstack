include <../common.scad>
include <./screws.scad>
include <../rpi/voronoi.scad>

vU = 2;
uHeight = 10;

plateScrewDiffV = uHeight*vU;
plateScrewDiffH = 180;

plateScrewToHEdge = 4.5;
plateScrewToVEdge = 5.5;

frontPlateThickness = 2.5;

frontPlateV = plateScrewDiffV + 2*plateScrewToHEdge;
frontPlateH = plateScrewDiffH + 2*plateScrewToVEdge;


plateScrewToBoxMin = 6;

module _frontPlateBody() {
  translate(v=[-plateScrewToVEdge,0,-plateScrewToHEdge])
    cube(size=[frontPlateH,frontPlateThickness,frontPlateV]);
}

module _plateHole() {
  rotate(a=[90,0,0])
  cylinder(r=m4RadiusSlacked, h=inf, center=true);
}


module frontPlate() {

  difference() {
    _frontPlateBody();

    union() {
      // TODO: introduce helper modules for this pattern
      _plateHole();

      translate(v=[plateScrewDiffH,0,0])
        _plateHole();

      translate(v=[0,0,plateScrewDiffV])
        _plateHole();

      translate(v=[plateScrewDiffH,0,plateScrewDiffV])
        _plateHole();
    }
  }
}

difference() {
  difference () {
    rotate(a=[-90,0,0])
      frontPlate();
    translate(v=[0,0,-5])
      voronoi3u_N(10);  
  }
// lug holes
  union() {
    translate(v=[160,-3,-frontPlateThickness])
    cube(size=[5.2, 5.2, 3]);
    translate(v=[160-88,-3,-frontPlateThickness])
    cube(size=[5.2, 5.2, 3]);
  }
}




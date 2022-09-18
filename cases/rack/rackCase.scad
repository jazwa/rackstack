include <../common.scad>
include <./screws.scad>
include <../rockpro/rockpro.scad>

vU = 4;
uHeight = 10;

plateScrewDiffV = uHeight*vU;
plateScrewDiffH = 180;

plateScrewToHEdge = 4.5;
plateScrewToVEdge = 5.5;

frontPlateThickness = 2.5;

frontPlateV = plateScrewDiffV + 2*plateScrewToHEdge;
frontPlateH = plateScrewDiffH + 2*plateScrewToVEdge;


plateScrewToBoxMin = 6;

// BOX CONFIG

// box dimensions
boxDepth = 135;
boxWidth = 95;

boxBottomThickness = 1;
boxSideThickness = 2;
boxBackThickness = 2;
// boxFrontThickness is just frontPlateThickness



boxTopSpace = 1; // meant for lids?
boxBottomSpace = 1; // meant to be used for boxes that expect support rails


boxHeight = vU * uHeight + 2*plateScrewToHEdge - (boxBottomSpace+boxTopSpace);



// all of these are defined on the xy plane with centered zLen height
// 'rise' is meant model how raised a pcb is. More specifically, the distance between the top of
// the pcb and the bottom of the inside of the case
module frontFaceHoles(zLen, rise) {

  //mirror(v=[0,1,0])
//    translate(v=[5,-eps,rise])
  //frontFaceIOCutouts_N();
}

module backFaceHoles(zLen, rise) {
}

module leftFaceHoles(zLen, rise) {
}

module rightFaceHoles(zLen, rise) {
}




module boxBody() {
  // save this transformation...
  // translate(v=[(plateScrewDiffH-boxWidth)/2.0,0,boxBottomSpace -plateScrewToHEdge])

  // convert to inside box space
  translate(v=[-boxSideThickness, -frontPlateThickness, -boxBottomThickness])
  difference() {
    cube(size=[boxWidth, boxDepth, boxHeight]);
    translate(v=[boxSideThickness, frontPlateThickness, boxBottomThickness])
      cube(size=[boxWidth-2*boxSideThickness, boxDepth-(boxBackThickness+frontPlateThickness), inf]);
  }

  
}


*difference() {
  boxBody();

  translate(v=[7,2,5])
    cutoutProfile_N();
}

translate(v=[7,2,5])
*cutoutProfile_N();




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

    // TODO REMOVE. Used to save on filament and print time
    scale(v=[0.8, 1+eps, 0.5])
      translate(v=[0,-eps,0])
      translate(v=[21,0,5])
      _frontPlateBody();
  }
}


frontPlate();

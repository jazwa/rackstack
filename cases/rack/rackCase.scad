include <../common.scad>
include <./screws.scad>
include <../risers.scad>

// TODO currently only for rockpro64 - make generic

vU = 3;
uHeight = 10;


// Front Plate dimensions
frontPlateScrewDiffV = uHeight*vU;
frontPlateScrewDiffH = 180;

frontPlateHeightTopSpace = 0.25; // Give some space at the top for the lid
frontPlateHeightBottomSpace = 0;

frontPlateHeight = (vU+1)*uHeight - (frontPlateHeightBottomSpace+frontPlateHeightTopSpace);
frontPlateWidth = 190;

frontPlateBottomScrewToHEdge = uHeight/2 + frontPlateHeightBottomSpace;
frontPlateTopScrewToHEdge = uHeight/2 + frontPlateHeightTopSpace;

frontPlateScrewToVEdge = (frontPlateWidth - frontPlateScrewDiffH)/2;

frontPlateThickness = 2.5;


plateScrewToBoxMin = 6;

// BOX CONFIG

// box dimensions
boxDepth = 132;
boxWidth = 160;

boxBottomThickness = 2;
boxSideThickness = 2;
boxBackThickness = 2;
boxFrontThickness = 2;

boxTopSpace = 1; // meant for lids?
boxBottomSpace = 1; // meant to be used for boxes that expect support rails (edit: not using right now)

boxHeight = (vU+1) * uHeight - (boxBottomSpace+boxTopSpace);


boxInnerDepth = boxDepth - (boxBackThickness+boxFrontThickness);
boxInnerHeight = boxHeight - boxBottomThickness; // TODO support lids
boxInnerWidth = boxWidth - 2*boxSideThickness;


// all of these are defined on the xy plane with centered zLen height
// 'rise' is meant model how raised a pcb is. More specifically, the distance between the top of
// the pcb and the bottom of the inside of the case
module frontFace_N(zLen, rise) {
  translate(v=[7.5,2,0])
  cube(size=[boxInnerWidth - 15, boxInnerHeight-8, zLen]);
}

module backFace_N(zLen, rise) {
  translate(v=[7.5,2,0])
    cube(size=[boxInnerWidth - 15, boxInnerHeight-8, zLen]);
}

module leftFace_N(zLen, rise) {
  translate(v=[7.5,2,0])
  cube(size=[boxInnerDepth - 15, boxInnerHeight-8, zLen]);
}

module rightFace_N(zLen, rise) {
  translate(v=[7.5,2,0])
  cube(size=[boxInnerDepth - 15, boxInnerHeight-8, zLen]);
}

module boxBody() {
  // save this transformation...
  // translate(v=[(plateScrewDiffH-boxWidth)/2.0,0,boxBottomSpace -plateScrewToHEdge])

  // convert to inside box space
  translate(v=[-boxSideThickness, -boxFrontThickness, -boxBottomThickness])
  difference() {
    cube(size=[boxWidth, boxDepth, boxHeight]);
    translate(v=[boxSideThickness, boxFrontThickness, boxBottomThickness])
      cube(size=[boxWidth-2*boxSideThickness, boxDepth-(boxBackThickness+boxFrontThickness), inf]);
  }

}

module boxBodyWithHoles() {

  m_trans_back =
    [ [-1, 0, 0, boxInnerWidth],
      [0, -1, 0, boxInnerDepth-boxBackThickness],
      [0, 0, 1,  0],
      [0, 0, 0,  1]];

  m_trans_left_side =
    [ [cos(-90), -sin(-90), 0, 0],
      [sin(-90), cos(-90), 0, boxInnerDepth],
      [0, 0, 1,  0],
      [0, 0, 0,  1]];

  m_trans_right_side =
    [ [cos(90), -sin(90), 0, boxInnerWidth],
      [sin(90), cos(90), 0, 0],
      [0, 0, 1,  0],
      [0, 0, 0,  1]];

  difference() {

    boxBody();

    union() {
      rotate(a=[90,0,0])
        frontFace_N(10, 0);

      multmatrix(m_trans_back)
        rotate(a=[90,0,0])
          backFace_N(10, 0);

      multmatrix(m_trans_left_side)
        rotate(a=[90,0,0])
          leftFace_N(10, 0);

      multmatrix(m_trans_right_side)
        rotate(a=[90,0,0])
          rightFace_N(10, 0);
    }
  }
}

// lid + lugging
module cylinderLug_M(length, radius) {
  rotate(a=[0,90,0])
  cylinder(h=length, r=radius, center=true);
}

module cylinderLug(lMult=1, rMult=1) {
  cylinderLug_M(6*lMult, 1*rMult);
}

function lerp(u, a, b) = (1-u)*a + u*b;

module lugLine(a,b, numLugs, lMult=1, rMult=1) {
  assert(numLugs>0);

  // require straight line that is level (same z values) either parallel with the x axis, or y axis
  // this just avoids some math and simplifies things
  assert(a[2] == b[2] && (a[0]==b[0] || a[1]==b[1]));

  direction = norm(b-a);

  for (i=[0:numLugs-1]) {
    u = (i+1)/(numLugs+1);

    if (a[1] == b[1]) {
      translate(v=lerp(u,a,b))
        cylinderLug(lMult, rMult);
    } else if (a[0] == b[0]) {
      translate(v=lerp(u,a,b))
        rotate(a=[0,0,90])
          cylinderLug(lMult,rMult);
    }
  }
}

module lugProfile(height, sideEps=0, lMult=1, rMult=1) {
  points = [
      [0+sideEps,0+sideEps,height],
      [boxInnerWidth-sideEps,0+sideEps,height],
      [boxInnerWidth-sideEps, boxInnerDepth-sideEps, height],
      [0+sideEps, boxInnerDepth-sideEps, height]
    ];

  for (i=[1:4]) {
    lugLine(points[(i-1)%4], points[i%4], 3, lMult, rMult);
  }

}

module lidBody() {
  topLidThickness = 1;
  bottomLidThickness = 4;
  bottomLidWallThickness = 2;

  translate(v=[-boxSideThickness, -boxFrontThickness,0])
    cube(size=[boxWidth, boxDepth, topLidThickness]);

  difference() {
    innerWallTolerance = 0.1;
    innerWallWidth = boxWidth - 2 * boxSideThickness - innerWallTolerance;
    innerWallDepth = boxDepth - (boxFrontThickness + boxBackThickness) - innerWallTolerance;

    translate(v = [innerWallTolerance/2, innerWallTolerance/2, topLidThickness])
      cube(size = [innerWallWidth, innerWallDepth,
        bottomLidThickness]);

    translate(v = [bottomLidWallThickness, bottomLidWallThickness, topLidThickness])
      cube(size = [boxWidth - 2*boxSideThickness - 2*bottomLidWallThickness, boxDepth - (boxFrontThickness + boxBackThickness) - 2*bottomLidWallThickness,
        bottomLidThickness]);
  }
}


module lid() {

  difference() {
    union() {
      lidBody();
      // todo figure out relation
      lugProfile(3, sideEps = 0.25, lMult=0.95, rMult=0.95);
    }

    for (i=[0:7]) {
      translate(v=[i*17 + 14, 15,-2])
        minkowski() {
          cylinder(r=1,h=1);
          cube(size = [10, 20, 5]);
        }
    }
  }
}

module case() {
  difference() {

    union() {
      boxBodyWithHoles();

      translate(v=[20,5, -1])
      rockProScrewMounts();

      // lugs
      translate(v=[0,-(1+boxFrontThickness),0])
        cube(size=[4,1,4]);

      translate(v=[boxInnerWidth-4,-(1+boxFrontThickness),0])
        cube(size=[4,1,4]);
    }

    union() {
      lugProfile(boxHeight-4); // todo reliant on box bottom thickness

      translate(v=[32,25,-2])
      minkowski() {
        cylinder(r=1,h=0.1);
        cube(size = [50, 80, 5]);
      }
    }
  }

}

/////////////////////////////////////////////////////////////////////////////////

module _frontPlateBody() {
    cube(size=[frontPlateWidth,frontPlateThickness,frontPlateHeight]);
}

module _plateHole() {
  rotate(a=[90,0,0])
  cylinder(r=m4RadiusSlacked, h=inf, center=true);
}

module frontPlate() {
  difference() {
    _frontPlateBody();

    translate(v=[frontPlateScrewToVEdge, 0, frontPlateBottomScrewToHEdge])
    union() {
      // TODO: introduce helper modules for this pattern
      _plateHole();

      translate(v=[frontPlateScrewDiffH,0,0])
        _plateHole();

      translate(v=[0,0,frontPlateScrewDiffV])
        _plateHole();

      translate(v=[frontPlateScrewDiffH,0,frontPlateScrewDiffV])
        _plateHole();
    }

  }
}


module frontPlateAligned() {

  difference() {
    // Aligned with case
    translate(v = [
      -(boxSideThickness + (frontPlateWidth - boxWidth) / 2),
      -(boxFrontThickness+frontPlateThickness),
      -boxBottomThickness
    ])
      frontPlate();

    union() {
      // lugs
      translate(v=[-0.05,-(1.5+boxFrontThickness),-0.05])
        cube(size=[4+0.1,2,4+0.1]);

      translate(v=[-0.05 + (boxInnerWidth-4),-(1.5+boxFrontThickness),-0.05])
        cube(size=[4+0.1,2,4+0.1]);

    }
  }
}


module rockPro64FrontPlate() {

  difference() {
    frontPlateAligned();

    union() {
      translate(v=[-1,-4,22])
      rotate(a=[90,0,0])
        linear_extrude(10)
          text("rock-2", font="Tlwg Mono:style=Bold", size=9);

      minkowski() {
        rotate(a=[90,0,0])
        cylinder(h=1, r=1);

        union() {
          translate(v = [24, - 10, 7])
            cube(size = [62, 10, 9]);

          translate(v = [52, - 10, 7])
            cube(size = [34, 10, 18]);

        }
      }

      intersection() {
        translate(v = [95, - 10, 3])
          cube(size = [70, 20, 26]);


        for(i=[0:9]) {

          translate(v = [83 + 8*i, - 10, 0])
            rotate(a=[0,30,0])
              cube(size=[3, 15, 50]);
        }
      }

    }
  }
}



rockPro64FrontPlate();
//translate(v=[0,-20,0])
//frontPlateAligned();

//case();

//translate(v=[0,0,50])
//mirror(v=[0,0,1])
//lid();
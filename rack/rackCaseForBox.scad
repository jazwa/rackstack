
/* Simple configurable rack mount component to hold a box-like shell */

include <../common.scad>
include <./screws.scad>

slack = 0.4;

boxWidth = 157.67;
boxHeight = 27.0;
boxLength = 101.5+1;

topThickness = 1.0;
bottomThickness = 1.0;

faceThickness = 3.0;
sideThickness = 2.0;
sideSupportWidth = 10;

railWidth = 16.0;

totalHeight = boxHeight+topThickness+bottomThickness;
totalLength = boxLength+2*sideThickness;


railMountWidthDiff = (200.0 - (boxWidth + 2*sideThickness)) / 2.0;

totalMountLength = 200.0 + 2*faceThickness + 1;
  
module sideHolder() {


  module frontLowerCaseSegment() {
    translate(v=[0,0,0])
      cube(size=[sideSupportWidth, faceThickness, bottomThickness]);
  }

  module frontUpperCaseSegment() {
    // no room for slack? :(
    translate(v=[0,0,boxHeight+bottomThickness])
      cube(size=[sideSupportWidth, faceThickness, topThickness]);
  }

  module backLowerCaseSegment() {
      translate(v=[0,boxLength+slack+sideThickness,0])
        frontLowerCaseSegment();
  }

  module backUpperCaseSegment() {
      translate(v=[0,boxLength+slack+sideThickness,0])
        frontUpperCaseSegment();
  }

  module backLowerRailSegment() {
    translate(v=[0,200.0+1,0])
      cube(size=[sideSupportWidth, faceThickness, bottomThickness]);
  }

  
  module backUpperRailSegment() {
    translate(v=[0,200.0+1,boxHeight+bottomThickness])
      cube(size=[sideSupportWidth, faceThickness, topThickness]);
  }

  module frontRailMountSegment() {
    // +2 is slack
    translate(v=[-railMountWidthDiff+5,0,0])
      // should technically use different totalHeight, as current totalHeight is for case holder
      cube(size=[railWidth,faceThickness,totalHeight]);
  }

  module backRailMountSegment() {
    translate(v=[0,200+1,0])
      // should technically use different totalHeight, as current totalHeight is for case holder
      frontRailMountSegment();
  }


  module frontFace() {
    difference() {
      hull() {
        frontLowerCaseSegment();
        frontUpperCaseSegment();
        frontRailMountSegment();
      }

      // screw holes
      translate(v=[-railMountWidthDiff + 11.5,0,5])
        rotate(a=[90,0,0])
        cylinder(r=m4RadiusSlacked, h=10, center=true);

      translate(v=[-railMountWidthDiff + 11.5,0,25])
        rotate(a=[90,0,0])
        cylinder(r=m4RadiusSlacked, h=10, center=true);
    }
    
  }

  module backFace() {
    translate(v=[0,200.0+faceThickness+1,0])
      frontFace();
      
  }

  frontFace();
  backFace();

  

  hull() {
    frontLowerCaseSegment();
    backLowerCaseSegment();
  }

  hull() {
    backLowerCaseSegment();
    backUpperCaseSegment();
  }

  hull() {
    frontUpperCaseSegment();
    backUpperCaseSegment();
  }


  hull() {
    backLowerRailSegment();
    backLowerCaseSegment();
  }

  hull() {
    backUpperRailSegment();
    backUpperCaseSegment();
  }

  // side support/hold for case
  difference() {
    cube(size=[sideThickness, totalLength, totalHeight]);

    translate(v=[-eps/2,8,5])
      cube(size=[sideThickness+eps,totalLength-17.5+eps, totalHeight-10+eps]);
  }


  // side support/hold for case
  difference() {
    translate(v=[sideSupportWidth-sideThickness,totalLength,0])
    cube(size=[sideThickness, totalMountLength-totalLength, totalHeight]);

    translate(v=[sideSupportWidth-sideThickness-eps/2,(200-totalLength)+20,5])
      cube(size=[sideThickness+eps,(200-totalLength)-10+eps, totalHeight-10+eps]);
  }
}


module sideHolderAligned() {
  //translate(v=[19,0,0])
    sideHolder();
}

module mSide() {
  mirror(v=[1,0,0]) {
    sideHolderAligned();
  }
}

sideHolderAligned();

//translate(v=[42 + boxWidth,0,0])
//mSide();


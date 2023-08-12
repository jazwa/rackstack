include <../helper/common.scad>
include <../config/common.scad>
include <../rack/sharedVariables.scad>
include <./common.scad>

sideSupportRailBase(u=2, double=true, top=true, baseThickness=1.5, sideThickness=4, backThickness=2, supportedZ=27.2, supportedY=101.5, supportedX=159);

// distance between front and back main rail screw mounts
sideRailScrewMountDist = yBarDepth - 2*(frontScrewSpacing + railFrontThickness + railSlotToXZ);

module sideSupportRailBase(u=2, double=true, top=true, baseThickness=2, sideThickness=2, backThickness=2, supportedZ=27.5, supportedY=101.5, supportedX=159) {

  mountBlockHeight = 10;
  mountBlockDepth = 10;
  screwMountGlobalDz = screwDiff / 2.0; // vertical distance between local origin and main rail screw mount
  sideRailScrewToMainRailFrontDx = frontScrewSpacing+railFrontThickness;
  railLength = max(sideRailScrewMountDist + sideRailScrewToMainRailFrontDx + mountBlockDepth/2, supportedY+backThickness);
  railBaseThickness = baseThickness;
  railSideThickness = sideThickness;
  railBaseWidth = 15;
  railSideHeight = supportedZ + railBaseThickness*2 + overhangSlack;

  frontMountPad = (sideRailScrewToMainRailFrontDx-mountBlockDepth/2)-xySlack;

  applyMainRailMounts()
  sideSupportRailBase();

  echo(frontScrewSpacing);
  echo(sideRailScrewToMainRailFrontDx);

  module applyMainRailMounts() {
    mountBlockExtension = (railSupportsDx - supportedX)/2 - railSideThickness;
    assert(mountBlockExtension >= 10);

    apply_p() {
      union() {
        translate(v = [0, frontMountPad, 0])
        mountBlockColumn(mountBlockExtension=mountBlockExtension, u=u);
        translate(v=[0,frontMountPad+sideRailScrewMountDist, 0])
        mountBlockColumn(mountBlockExtension=mountBlockExtension, u=u);
      }
      children(0);
    }
  }

  module mountBlockColumn(mountBlockExtension, u) {

    difference() {
      translate(v = [-mountBlockExtension, 0, 0])
      cube(size = [mountBlockExtension, mountBlockDepth, railSideHeight]);

      union() {
        nutPocket();

        if (double) {
          translate(v=[0,0,uDiff * u]) // screwMountToGlobalZ
          nutPocket();
        }

      }
    }

    module nutPocket() {
      translate(v=[-mountBlockExtension/2,mountBlockDepth/2,mountBlockHeight/2]) // screwMountToGlobalZ
      rotate(a=[90,0,0])
      rotate(a=[0,90,0])
      hexNutPocket_N(rackFrameScrewType, openSide=false);
    }

  }

  module sideSupportRailBase() {
    backThickness = 3;

    difference () {
      union() {
        cube(size = [railBaseWidth, railLength, railBaseThickness]);

        cube(size = [railSideThickness, railLength, railSideHeight]);

        // back support
        translate(v = [0, max(railLength-backThickness, supportedY), 0])
        cube(size = [railBaseWidth, backThickness, railSideHeight]);

        // back support for box
        translate(v = [0, supportedY, 0])
        cube(size = [railBaseWidth, backThickness, railSideHeight]);

        // top support
        if (top) {
          translate(v = [0, 0, railSideHeight-baseThickness])
          cube(size = [railBaseWidth, railLength, railBaseThickness]);
        }

      }
      union() {
        distanceFromSeparator = 3;
        r = 5;

        boxDy = frontMountPad+r+mountBlockDepth+distanceFromSeparator;
        boxDz = baseThickness+distanceFromSeparator+r;
        translate(v=[0,boxDy,boxDz])
        minkowski() {
          cube(size = [sideThickness, supportedY-(boxDy+distanceFromSeparator+r), railSideHeight-2*boxDz]);
          sphere(r=r);
        }
        translate(v=[0,supportedY+distanceFromSeparator+r+backThickness,boxDz])
        minkowski() {
          cube(size = [sideThickness, 25, railSideHeight-2*boxDz]); // TODO calculate 22.5
          sphere(r=r);
        }

        cylindricalFiletNegative(p0=[railBaseWidth,0,0],p1=[railBaseWidth,0,inf], n=[1,-1,0],r=4);
      }
    }
  }

}




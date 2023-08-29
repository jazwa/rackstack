include <../helper/common.scad>
include <../config/common.scad>
include <../rack/sharedVariables.scad>
include <./common.scad>

//sideSupportRailBase(top=true, defaultThickness=1.5, supportedZ=27.2, supportedY=101.5, supportedX=159);

// distance between front and back main rail screw mounts
sideRailScrewMountDist = yBarDepth - 2*(frontScrewSpacing + railFrontThickness + railSlotToXZ);

module sideSupportRailBase(top=true, supportedZ, supportedY, supportedX, zOrientation="middle", defaultThickness=2) {

  mountBlockHeight = 10;
  mountBlockDepth = 10;
  screwMountGlobalDz = screwDiff / 2.0; // vertical distance between local origin and main rail screw mount
  sideRailScrewToMainRailFrontDx = frontScrewSpacing+railFrontThickness;
  railLength = max(sideRailScrewMountDist + sideRailScrewToMainRailFrontDx + mountBlockDepth/2, supportedY+defaultThickness);
  railBaseThickness = defaultThickness; // default thickness value
  railSideThickness = 4;
  railBackThickness = 3;
  railBaseWidth = 15;
  // Minimum U to enclose box, while also have a minimum defaultThickness for top and bottom.
  minU = max(1, ceil((supportedZ + 2*railBaseThickness) / uDiff)-1);

  railBottomThickness =
    (zOrientation == "middle")
    ? (((minU+1) * uDiff) - supportedZ)/2
    : (zOrientation == "bottom")
    ? railBaseThickness
    : railBaseThickness;

  assert(supportedX <= maxUnitWidth);
  assert (zOrientation == "middle" || zOrientation == "bottom", "Z-Orientation not supported");
  assert(railBottomThickness >= railBaseThickness);

  railSideHeight = supportedZ + railBaseThickness + railBottomThickness + overhangSlack;
  frontMountPad = (sideRailScrewToMainRailFrontDx-mountBlockDepth/2)-xySlack;

  translate(v=[-railSideThickness, 0, -railBottomThickness])
  applyMainRailMounts()
  sideSupportRailBase();

  module applyMainRailMounts() {

    mountBlockExtension = (railSupportsDx - supportedX)/2 - railSideThickness;
    minHexNutPocketToXYDist = mountBlockHeight/2;
    minHexNutPocketToXZDist = mountBlockDepth/2;
    minHexNutPocketToYZDist = 4;
    screwU = floor((railSideHeight) / uDiff)-1;

    apply_pn() {
      mountBlockPositive();
      mountBlockNegative();
      children(0);
    }

    module mountBlockPositive() {
      translate(v = [0, frontMountPad, 0])
        singleMountBlockPositive();
      translate(v=[0,frontMountPad+sideRailScrewMountDist, 0])
        singleMountBlockPositive();
    }

    module mountBlockNegative() {
      translate(v = [0, frontMountPad, 0])
        singleMountBlockNegative();
      translate(v=[0,frontMountPad+sideRailScrewMountDist, 0])
        singleMountBlockNegative();
    }

    module singleMountBlockPositive() {
      translate(v = [-mountBlockExtension, 0, 0])
        cube(size = [mountBlockExtension, mountBlockDepth, railSideHeight]);
    }

    module singleMountBlockNegative() {
      nutPocket();

      translate(v = [0, 0, uDiff*screwU])
        nutPocket();

      module nutPocket() {
        translate(v=[-mountBlockExtension+minHexNutPocketToYZDist, minHexNutPocketToXZDist, minHexNutPocketToXYDist])
        rotate(a=[-90,0,90])
          hexNutPocket_N(rackFrameScrewType, openSide=false, backSpace=min((railSideThickness-1)+mountBlockExtension-minHexNutPocketToYZDist,15));
      }
    }
  }


  module sideSupportRailBase() {

    difference () {
      union() {
        cube(size = [railBaseWidth, railLength, railBottomThickness]);

        cube(size = [railSideThickness, railLength, railSideHeight]);

        // back support
        translate(v = [0, max(railLength-railBackThickness, supportedY), 0])
        cube(size = [railBaseWidth, railBackThickness, railSideHeight]);

        // back support for box
        translate(v = [0, supportedY, 0])
        cube(size = [railBaseWidth, railBackThickness, railSideHeight]);

        // top support
        if (top) {
          translate(v = [0, 0, railSideHeight-railBaseThickness])
          cube(size = [railBaseWidth, railLength, railBaseThickness]);
        }
      }

      union() {
        distanceFromSeparator = 3;
        r = 4;

        ventDy1 = frontMountPad+mountBlockDepth+distanceFromSeparator;
        ventY1 = min(supportedY-(ventDy1+distanceFromSeparator), sideRailScrewMountDist-(2*distanceFromSeparator+mountBlockDepth));

        ventDy2 = max(ventDy1, supportedY+railBackThickness+distanceFromSeparator);
        ventY2 = max(0, railLength - (ventDy2 + distanceFromSeparator + mountBlockDepth));

        ventDz = railBottomThickness+distanceFromSeparator+r;
        ventZ = railSideHeight-(ventDz+distanceFromSeparator+r+railBaseThickness);

        if (ventY1 > 2*r) {
          translate(v = [0, ventDy1+r, ventDz])
            minkowski() {
              cube(size = [inf, ventY1-2*r, ventZ]);
              sphere(r = r);
            }
        }

        if (ventY2 > 2*r) {
          translate(v = [0, ventDy2+r, ventDz])
            minkowski() {
              cube(size = [inf, ventY2-2*r, ventZ]);
              sphere(r = r);
            }
        }

        cylindricalFiletNegative(p0=[railBaseWidth,0,0],p1=[railBaseWidth,0,inf], n=[1,-1,0],r=r);
      }
    }
  }

}




include <../common.scad>
include <./helper.scad>

// sideSupportRailBase(top=true, defaultThickness=1.5, supportedZ=27.2, supportedY=101.5, supportedX=159);


module sideSupportRailBase(top=true, recess=false, supportedZ, supportedY, supportedX, zOrientation="middle", defaultThickness=2, railSideThickness=4, sideVent=true) {

  mountBlockDepth = 10;
  screwMountGlobalDz = screwDiff / 2.0; // vertical distance between local origin and main rail screw mount
  sideRailScrewToMainRailFrontDx = frontScrewSpacing+railFrontThickness;
  railLength = max(sideRailScrewMountDist + sideRailScrewToMainRailFrontDx + mountBlockDepth/2, supportedY+defaultThickness);
  railBaseThickness = defaultThickness; // default thickness value
  railBackThickness = 3;
  // Minimum U to enclose box, while also have a minimum defaultThickness for top and bottom.
  u = findU(supportedZ, railBaseThickness);
  railBottomThickness = railBottomThickness(u, supportedZ, railBaseThickness, zOrientation);

  assert(supportedX <= maxUnitWidth, "Configured supported width is too high for rack profile");
  assert (zOrientation == "middle" || zOrientation == "bottom", "Z-Orientation not supported");
  assert(railBottomThickness >= railBaseThickness);
  // require recessed rail if supportedX is close to maxUnitWidth
  assert(recess || (supportedX+2*railSideThickness <= maxUnitWidth), "Configured supported width requires recessed side rail.");

  railSideHeight = supportedZ + railBaseThickness + railBottomThickness + overhangSlack;
  frontMountPad = (sideRailScrewToMainRailFrontDx-mountBlockDepth/2);

  translate(v=[-railSideThickness, 0, -railBottomThickness])
  applyMainRailMounts()
  sideSupportRailBase();

  module applyMainRailMounts() {

    mountBlockExtension = (railSupportsDx - supportedX)/2 - railSideThickness;
    minHexNutPocketToXYDist = sideRailLowerMountPointToBottom;
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
        cube(size = [sideRailBaseWidth, railLength, railBottomThickness]);

        cube(size = [railSideThickness, railLength, railSideHeight]);

        // back support
        translate(v = [0, max(railLength-railBackThickness, supportedY), 0])
        cube(size = [sideRailBaseWidth, railBackThickness, railSideHeight]);

        // back support for box
        translate(v = [0, supportedY, 0])
        cube(size = [sideRailBaseWidth, railBackThickness, railSideHeight]);

        // top support
        if (top) {
          translate(v = [0, 0, railSideHeight-railBaseThickness])
          cube(size = [sideRailBaseWidth, railLength, railBaseThickness]);
        }
      }
      if (sideVent) {
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

        frontCutTrans = recess ? translate(v=[0,frontMountPad,0]): translate(v=[0,xySlack,0]);
        multmatrix(frontCutTrans) {
          cylindricalFiletNegative(p0=[sideRailBaseWidth,0,0],p1=[sideRailBaseWidth,0,inf], n=[1,-1,0],r=r);
          halfspace(vpos=[0,-1,0], p=[0,0,0]);
        }

      }
      }
    }
  }

}




include <../../helper/common.scad>
include <../../helper/math.scad>
include <../../helper/screws.scad>
include <../../rack/config.scad>

*sideSupportRailBase("lBracket");

module sideSupportRailBase(type) {

  railLength = 100;
  railBaseThickness = 2;
  railBaseWidth = 18;
  railSideThickness = 2;
  railSideHeight = 12;
  sideDy = -2;

  frontMountPad = 10; // depends on y of box to be mounted TODO calculate this
  sideMountPad = 10; // depends on x of box TODO calculate this
  // distance between front and back main rail screw mounts
  screwMountDist = 62; // TODO calculate this instead of hardcode
  // vertical distance between local origin and main rail screw mount
  screwMountGlobalDz = screwDiff / 2.0;


  applyMainRailMounts()
  sideSupportRailBaseHolder();

  module sideSupportRailBaseHolder() {
    if (type == "lBracket") {
      sideSupportRailBaseLBracket();
    } else {
      error("Unsupported side support type");
    }
  }


  module applyMainRailMounts() {

    apply_p() {
      translate(v=[0,frontMountPad,0])
      union() {
        dualMount();

        translate(v=[0,screwMountDist,0])
        dualMount();
      }

      children(0);
    }
  }

  module dualMount() {

    blockHeight = railSideHeight - sideDy;

    difference() {
      // mount block
      translate(v = [-sideMountPad, 0, sideDy])
      cube(size = [sideMountPad, 10, blockHeight+sideDy]);

      // screw mount
      translate(v=[-5,5,5]) // screwMountToGlobalZ
      rotate(a=[90,0,0])
      rotate(a=[0,90,0])
      hexNutPocket_N(rackFrameScrewType, openSide=false);
    }

  }

  module sideSupportRailBaseLBracket(backSupport=true, backThickness=3) {

    translate(v=[0, 0, sideDy])
    union() {
      cube(size = [railBaseWidth, railLength, railBaseThickness]);
      cube(size = [railSideThickness, railLength, railSideHeight]);

      if (backSupport) {
        translate(v=[0, railLength-backThickness, 0])
        cube(size=[railBaseWidth, backThickness, railSideHeight]);
      }
    }
  }

  module sideSupportRailBaseDovetail() {}

  module sideSupportRailBaseBoxed() {}

}




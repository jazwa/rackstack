include <../../helper/common.scad>
include <../../helper/math.scad>
include <../../helper/screws.scad>
include <../../rack/config.scad>
include <../../rack/sharedVariables.scad>

*sideSupportRailBase("lBracket");
// TODO: make this parametric

// distance between front and back main rail screw mounts
sideRailScrewMountDist = yBarDepth - 2*(frontScrewSpacing + railFrontThickness + railSlotToXZ); // TODO use transformation matrices

module sideSupportRailBase(type) {

  // vertical distance between local origin and main rail screw mount
  screwMountGlobalDz = screwDiff / 2.0;

  railLength = sideRailScrewMountDist + 30; // TODO calculate this
  railBaseThickness = 2;
  railBaseWidth = 18;
  railSideThickness = 2;
  railSideHeight = 15;
  sideDy = -2;
  frontMountPad = 10; // depends on y of box to be mounted TODO calculate this
  sideMountPad = 10; // depends on x of box TODO calculate this

  translate(v=[sideMountPad,-(frontMountPad + 5),-5])
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

        translate(v=[0,sideRailScrewMountDist,0])
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




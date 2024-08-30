include <../../helper/common.scad>
include <../../config/common.scad>
include <../sharedVariables.scad>
include <../side/sideWallVariables.scad>
include <../side/magnetModule.scad>
include <../side/hingeModule.scad>


module onYBarSideModuleNegative(fixed=false) {

  translate(v = [-xySlack/2, -xySlack/2, -sideWallConnLugDepression])
  cube(size = [sideWallConnW+xySlack, sideWallConnD+xySlack, sideWallConnLugDepression]);


  if (!fixed) {
    translate(v = [yBarScrewHoleToOuterYEdge, yBarScrewHoleToFrontXEdge, -(4+sideWallConnLugDepression)])
    rotate(a=[0,0,90])
    hexNutPocket_N("m3", openSide=false, backSpace=5, bridgeFront=true);
  }
}


module onYBarMagnetModulePositive() {
    

    translate(v=[sideWallConnW,0,-sideWallConnLugDepression])
        mirror(v=[1,0,0])
        magnetModule(fixed=true);


}

module onYBarHingeModulePositive() {
    
    translate(v=[sideWallConnW,0,-sideWallConnLugDepression])
    mirror(v=[1,0,0])
        hingeModule(fixed=false);
}

module onYBarHingeModuleNegative() {
    
    translate(v=[sideWallConnW,0,-sideWallConnLugDepression])
        mirror(v=[1,0,0])
        difference() {
            cube(size=[sideWallConnW,sideWallConnD,sideWallConnLugDepression]);            
            hingeModule(fixed=true);
        }
}

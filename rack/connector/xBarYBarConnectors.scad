include <../../helper/common.scad>
include <../../config/common.scad>
include <../sharedVariables.scad>

// On xBar
module onXBarToYBarNegative() {
  y = 27;
  z = 8;
  slack = xBarYBarDovetailSlack;

  translate(v=[-1,14,0])
  mirror(v=[1,0,0])
  rotate(a=[0,0,-90])
  dovetail(
      topWidth = 15+slack,
      bottomWidth = 12+slack,
      height = 2,
      length = yBarHeight,
      headExtension = 1+slack,
      baseExtension = 2,
      frontFaceLength = 0.5, // elephant foot compensation
      frontFaceScale = 1.05,
      backFaceLength = 5,
      backFaceScale = 1.2
  );

  // TODO clean this up
  translate(v = [-xBarSideThickness, y, z])
  rotate(a = [0, -90, 0])
  counterSunkHead_N(rackFrameScrewType, screwExtension=inf10, headExtension=inf10);

  // lugs for snap fit and hold in place
  translate(v=[-0.1,26,13.5])
  lug();
}

module onXBarToYBarPositive() {
  // lugs for snap fit and hold in place
  translate(v=[-0.1,26,2])
  lug();
}


// On yBar
module onYBarToXBarNegative() {
  y = 27;
  z = 8;
  translate(v = [-5, y, z])
  rotate(a = [180, 0, 0])
  rotate(a = [0, 90, 0])
  hexNutPocket_N("m3", openSide=false, backSpace=5);

  // lugs for snap fit and hold in place
  translate(v=[-0.1,26,2])
  lug();
}

module onYBarToXBarPositive() {

  translate(v=[1, 14,0]) // TODO: variable for the 14
  rotate(a=[0,0,-90])
  dovetail(
      topWidth = 15-xySlack, // figure out why we need this
      bottomWidth = 12,
      height = 2,
      length = yBarHeight,
      headExtension = 1,
      baseExtension = 2,
      frontFaceLength = 2,
      frontFaceScale = 0.95, // elephant foot compensation
      backFaceLength = 5,
      backFaceScale = 1.2
  );

  // lugs for snap fit and hold in place
  translate(v=[-0.1,26,13.5])
  lug();
}


xBarConnectorToYBarConnectorTrans = mirror(v=[1,0,0]);
yBarConnectorToXBarConnectorTrans = mirror(v=[-1,0,0]);


module lug() {
  hull() {
    sphere(r=0.5);

    translate(v=[0,2,0])
    sphere(r=0.5);
  }
}
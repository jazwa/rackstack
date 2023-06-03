include <../../helper/screws.scad>
include <../../helper/common.scad>
include <../../helper/matrix.scad>
include <../../helper/slack.scad>
include <../../helper/dovetail.scad>
include <../../helper/halfspace.scad>

include <../sharedVariables.scad>

include <../config.scad>

// On xBar
module onXBarToYBarNegative() {
  y = 27;
  z = 6;
  slack = xBarYBarDovetailSlack;

  translate(v=[-slack,14,0])
  mirror(v=[1,0,0])
  rotate(a=[0,0,-90])
  dovetail(
      topWidth = 15+slack,
      bottomWidth = 12+slack,
      height = 2+slack,
      length = yBarHeight,
      headExtension = 1,
      baseExtension = 2,
      frontFaceLength = 0.5,
      frontFaceScale = 1.05,
      backFaceLength = 5,
      backFaceScale = 1.2
  );

  // TODO clean this up
  translate(v = [-xBarSideThickness, y, z])
  rotate(a = [0, -90, 0])
  counterSunkHead_N(rackFrameScrewType, screwExtension=inf10, headExtension=inf10);
}


// On yBar
module onYBarToXBarNegative() {
  y = 27;
  z = 6;
  translate(v = [-5, y, z])
  rotate(a = [180, 0, 0])
  rotate(a = [0, 90, 0])
  hexNutPocket_N("m3", openSide=false, backSpace=5);

}

module onYBarToXBarPositive() {

  translate(v=[xBarYBarDovetailSlack, 14,0]) // TODO: variable for the 14
  rotate(a=[0,0,-90])
  dovetail(
      topWidth = 15-xySlack, // figure out why we need this
      bottomWidth = 12,
      height = 2,
      length = yBarHeight,
      headExtension = 1,
      baseExtension = 2,
      frontFaceLength = 2,
      frontFaceScale = 0.95,
      backFaceLength = 5,
      backFaceScale = 1.2
  );
}


xBarConnectorToYBarConnectorTrans = mirror(v=[1,0,0]);
yBarConnectorToXBarConnectorTrans = mirror(v=[-1,0,0]);
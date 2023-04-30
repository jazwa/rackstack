include <../helper/math.scad>
include <./config.scad>
include <./mainRail.scad>
include <./yBar.scad>
include <./xBar.scad>


attachXBarWithYBar();


module attachXBarWithYBar() {
  // assemble x-y bar trays

  yBar();

  xBarSpaceToYBarSpace =
      yBarXBarConnectorTrans *
      xBarConnectorToYBarConnectorTrans *
      inv4x4(xBarYBarConnectorTrans);

  yBarSpaceToXBarSpace =
      xBarYBarConnectorTrans *
      yBarConnectorToXBarConnectorTrans *
      inv4x4(yBarXBarConnectorTrans);

  multmatrix(
     xBarSpaceToYBarSpace *
     xBarMirrorOtherCornerTrans *
     yBarSpaceToXBarSpace
  )
  yBar();

  multmatrix(
    translate(v=[0,0,20]) *
     xBarSpaceToYBarSpace
  )
  xBar();


  multmatrix(
      translate(v=[0,0,20]) *
      yBarMirrorOtherCornerTrans *
      xBarSpaceToYBarSpace
  )
  xBar();
}


module screwXBarAndYBar() {
  // screw to connect x and y bars
}


module attachSideConnectorModulesToYBars() {
  // attach side connector modules to y bars
}


module insertDowelsIntoSideWall() {

}

module connectXYTraysWithMainRailAndSideWall() {

}

module screwMainRailAndYBar() {

}


module attachFeet() {

}

module attachTops() {

}
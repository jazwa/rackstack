include <../../helper/common.scad>
include <../../config/common.scad>
include <../sharedVariables.scad>


module stackConnectorBase(rectSlack, topSlack=0.0) {

  wSlacked = connectorRectWidth + rectSlack;
  dSlacked = connectorRectDepth + rectSlack;
  topRSlacked = connectorTopR + rectSlack/2;

  module connRect() {
    linear_extrude(height=eps)
    square(size = [wSlacked, dSlacked]);
  }

  module connTop() {
    linear_extrude(height=eps)
    circle(r=topRSlacked);
  }

  hull() {
    connRect();

    translate(v=[0,0,connectorTaperStartHeight])
    connRect();
  }

  hull() {
    translate(v = [0, 0, connectorTaperStartHeight])
    connRect();

    translate(v=[wSlacked/2, dSlacked/2, connectorTotalHeight+topSlack])
    connTop();
  }
}


module onYBarStackConnectorNegative() {

  wSlacked = connectorRectWidth + connectorRectSocketSlack;
  dSlacked = connectorRectDepth + connectorRectSocketSlack;

  bevelSlack = 0.6;
  bevelR = wSlacked + bevelSlack;
  bevelW = dSlacked + bevelSlack;
  bevelH = 0.6;

  screwExtension = 4;


  union() {
    stackConnectorBase(connectorRectSocketSlack, topSlack=0.4);

    translate(v = [-screwExtension, connectorRectDepth/2, connectorBottomToScrew])
    rotate(a = [0, -90, 0])
    counterSunkHead_N(rackFrameScrewType, screwExtension = 5, headExtension = 10);

    // bevel at the lip of the socket to guide the plug, as well as mitigate elephant foot during 3d printing
    hull() {
      translate(v = [0, 0, bevelH])
      linear_extrude(height = eps)
      square(size = [wSlacked, dSlacked]);

      translate(v = [-bevelSlack/2, -bevelSlack/2, 0])
      linear_extrude(height = eps)
      square(size = [bevelR, bevelW]);
    }
  }
}


module stackConnectorPlug() {

  difference() {
    stackConnectorBase(connectorRectPlugSlack);

    translate(v=[connectorRectWidth/2,connectorRectDepth/2,connectorBottomToScrew])
    rotate(a=[0,0,90])
    rotate(a=[90,0,0])
    hexNutPocket_N(rackFrameScrewType, openSide=false);
  }
}

module stackConnectorBottom() {

  height = 2; // space between bottom and floor

  stackConnectorPlug();
  translate(v=[0,0,-height])
  cube(size=[connectorRectWidth+connectorRectPlugSlack, connectorRectDepth+connectorRectPlugSlack, height]);
}

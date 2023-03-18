include <../helper/math.scad>
include <../helper/common.scad>
include <../misc/magnet.scad>

connectorRectWidth = 10;
connectorRectDepth = 10;
connectorTotalHeight = 10;
connectorSocketMagnetExtrudeHeight = 1;
connectorTaperStartHeight = 3;

connectorRectPlugSlack = -0.1;
connectorRectSocketSlack = 0.1;

connectorBottomToScrew = 6;

module stackConnectorBase(rectSlack) {

  wSlacked = connectorRectWidth + rectSlack;
  dSlacked = connectorRectDepth + rectSlack;

  module connRect() {
    linear_extrude(height=eps)
    square(size = [wSlacked, dSlacked]);
  }

  module connTop() {
    linear_extrude(height=eps)
    circle(r=3);
  }

  hull() {
    connRect();

    translate(v=[0,0,connectorTaperStartHeight])
    connRect();
  }

  hull() {
    translate(v = [0, 0, connectorTaperStartHeight])
    connRect();

    translate(v=[wSlacked/2, dSlacked/2, connectorTotalHeight])
    connTop();
  }
}


module stackConnectorSocket_N() {

  wSlacked = connectorRectWidth + connectorRectSocketSlack;
  dSlacked = connectorRectDepth + connectorRectSocketSlack;

  bevelSlack = 0.6;
  bevelR = wSlacked + bevelSlack;
  bevelW = dSlacked + bevelSlack;
  bevelH = 0.6;

  screwExtension = 4;

  union() {
    stackConnectorBase(connectorRectSocketSlack);

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

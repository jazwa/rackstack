include <../helper/math.scad>
include <../helper/common.scad>
include <../misc/magnet.scad>

connectorRectWidth = 10;
connectorRectDepth = 10;
connectorTotalHeight = 5;
connectorSocketMagnetExtrudeHeight = 1;
connectorTaperStartHeight = 2;

connectorRectPlugSlack = -0.1;
connectorRectSocketSlack = 0.1;

module stackConnectorBase(rectSlack) {

  wSlacked = connectorRectWidth + rectSlack;
  dSlacked = connectorRectDepth + rectSlack;

  module connRect() {
    linear_extrude(height=eps)
    square(size = [wSlacked, dSlacked]);
  }

  module connMagnetMount() {
    linear_extrude(height=eps)
    circle(r=magnetRSlacked);
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
    connMagnetMount();
  }
}

module stackConnectorPlug() {
  assert(magnetHSlacked > connectorSocketMagnetExtrudeHeight);

  wSlacked = connectorRectWidth + connectorRectPlugSlack;
  dSlacked = connectorRectDepth + connectorRectPlugSlack;

  magnetLevelHeight = connectorTotalHeight - (magnetHSlacked - connectorSocketMagnetExtrudeHeight);

  difference() {

    intersection() {
      stackConnectorBase(connectorRectPlugSlack);
      cube(size=[dSlacked, wSlacked, magnetLevelHeight]);
    }

      translate(v = [wSlacked/2, dSlacked/2, magnetLevelHeight - magnetHSlacked])
      cylinder(r = magnetRSlacked, h = magnetHSlacked);

  }
}

module stackConnectorSocket_N() {

  wSlacked = connectorRectWidth + connectorRectSocketSlack;
  dSlacked = connectorRectDepth + connectorRectSocketSlack;

  bevelSlack = 0.5;
  bevelR = wSlacked + bevelSlack;
  bevelW = dSlacked + bevelSlack;
  bevelH = 0.5;

  stackConnectorBase(connectorRectSocketSlack);

  translate(v=[wSlacked/2, wSlacked/2, connectorTotalHeight - connectorSocketMagnetExtrudeHeight])
  cylinder(r=magnetRSlacked, h=magnetHSlacked);

  // bevel at the lip of the socket to guide the plug, as well as mitigate elephant foot during 3d printing
  hull() {
    translate(v=[0,0,bevelH])
    linear_extrude(height=eps)
    square(size = [wSlacked, dSlacked]);

    translate(v=[-bevelSlack/2, -bevelSlack/2, 0])
    linear_extrude(height=eps)
    square(size = [bevelR, bevelW]);
  }
}

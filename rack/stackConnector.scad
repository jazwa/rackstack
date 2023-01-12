include <../helper/math.scad>
include <../helper/common.scad>
include <../misc/magnet.scad>

connectorTaperStartHeight = 2;
connectorRectWidth = 10;
connectorRectDepth = 10;

connectorTotalHeight = 5;

connectorRectPlugSlack = -0.1;
connectorRectSocketSlack = 0.1;

connectorSocketMagnetExtrudeHeight = 1;

module stackConnectorBase(rectSlack) {

  _wSlacked = connectorRectWidth + rectSlack;
  _dSlacked = connectorRectDepth + rectSlack;

  module connRect() {
    linear_extrude(height=eps)
    square(size = [_wSlacked, _dSlacked]);
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

    translate(v=[_wSlacked/2, _dSlacked/2, connectorTotalHeight])
    connMagnetMount();
  }
}

module stackConnectorPlug() {
  assert(magnetHSlacked > connectorSocketMagnetExtrudeHeight);

  _wSlacked = connectorRectWidth + connectorRectPlugSlack;
  _dSlacked = connectorRectDepth + connectorRectPlugSlack;

  magnetLevelHeight = connectorTotalHeight - (magnetHSlacked - connectorSocketMagnetExtrudeHeight);

  difference() {

    intersection() {
      stackConnectorBase(connectorRectPlugSlack);
      cube(size=[_dSlacked, _wSlacked, magnetLevelHeight]);
    }

      translate(v = [_wSlacked/2, _dSlacked/2, magnetLevelHeight - magnetHSlacked])
      cylinder(r = magnetRSlacked, h = magnetHSlacked);

  }
}

module stackConnectorSocket_N() {

  _wSlacked = connectorRectWidth + connectorRectSocketSlack;
  _dSlacked = connectorRectDepth + connectorRectSocketSlack;

  _bevelSlack = 0.5;
  _bevelR = _wSlacked + _bevelSlack;
  _bevelW = _dSlacked + _bevelSlack;
  _bevelH = 0.5;


  stackConnectorBase(connectorRectSocketSlack);

  translate(v=[_wSlacked/2, _wSlacked/2, connectorTotalHeight - connectorSocketMagnetExtrudeHeight])
  cylinder(r=magnetRSlacked, h=magnetHSlacked);

  // bevel at the lip of the socket to guide the plug, as well as mitigate elephant foot during 3d printing
  hull() {
    translate(v=[0,0,_bevelH])
    linear_extrude(height=eps)
    square(size = [_wSlacked, _dSlacked]);

    translate(v=[-_bevelSlack/2, -_bevelSlack/2, 0])
    linear_extrude(height=eps)
    square(size = [_bevelR, _bevelW]);
  }
}

module test() {
  difference() {
    union() {
      translate(v = [-2.5, -2.5, 0])
      cube(size = [15, 15, 10]);

      translate(v = [0, 0, 10])
      stackConnectorPlug();
    }

    stackConnectorSocket_N();
  }
}

*test();


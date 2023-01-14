include <../helper/common.scad>
include <../helper/halfspace.scad>
include <../helper/screws.scad>
include <./config.scad>

_mountX = 12;
_mountY = 14;
_mountZ = 13;

// x and y faces of the yBarBasePlateMount_P block
_innerXFaceToScrew = 6;
_innerYFaceToScrew = 8;

_baseConnRecession = 3;
_baseConnY = 8;
_baseConnOuterXFaceToScrew = 2;

module yBarBasePlateMount_P() {
  intersection() {
    cube(size = [_mountX, _mountY, _mountZ]);
    halfspace(vpos=[0, -1, -1], p=[0, _mountY-1, _mountZ-1]);
  }
}

module yBarBasePlateMount_N() {

  heatSetX = _mountX - _innerXFaceToScrew;
  heatSetY = _mountY - _innerYFaceToScrew;

  translate(v=[heatSetX, heatSetY, m3HeatSetInsertSlotHeightSlacked + _baseConnRecession])
  mirror(v=[0,0,1])
    heatSetInsertSlot_N(rackFrameScrewType, topExtension=inf10);


  hull() {

    translate(v = [heatSetX, heatSetY, 0])
    cylinder(r=_baseConnY/2, h=_baseConnRecession);

    translate(v = [inf50, heatSetY-_baseConnY/2, 0])
    cube(size = [eps, _baseConnY, _baseConnRecession]);
  }
}

*difference() {
  yBarBasePlateMount_P();
  yBarBasePlateMount_N();
}

//yBarBasePlateMount_N();

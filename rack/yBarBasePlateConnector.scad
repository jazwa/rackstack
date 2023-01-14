include <../helper/common.scad>
include <../helper/screws.scad>
include <./config.scad>

_mountX = 12;
_mountY = 12;
_mountZ = 12;

// x and y faces of the yBarBasePlateMount_P block
_innerXFaceToScrew = 6;
_innerYFaceToScrew = 6;

_baseConnRecession = 3;
_baseConnY = 8;
_baseConnOuterXFaceToScrew = 2;

module yBarBasePlateMount_P() {
  cube(size=[_mountX, _mountY, _mountZ]);
}

module yBarBasePlateMount_N() {

  heatSetX = _mountX - _innerXFaceToScrew;
  heatSetY = _mountY - _innerYFaceToScrew;

  translate(v=[heatSetX, heatSetY, m3HeatSetInsertSlotHeightSlacked + _baseConnRecession])
  mirror(v=[0,0,1])
    heatSetInsertSlot_N(rackFrameScrewType, topExtension=inf10);

  translate(v=[_baseConnOuterXFaceToScrew, heatSetY - _baseConnY/2,0])
  cube(size=[inf50, _baseConnY, _baseConnRecession]);
}

difference() {
  yBarBasePlateMount_P();
  yBarBasePlateMount_N();
}

//yBarBasePlateMount_N();

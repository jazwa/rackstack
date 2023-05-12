include <../../helper/screws.scad>
include <../../helper/common.scad>
include <../../helper/matrix.scad>
include <../../helper/slack.scad>
include <../../helper/dovetail.scad>
include <../../helper/halfspace.scad>

include <../sharedVariables.scad>

include <../config.scad>

_mountX = 12;
_mountY = 14;
_mountZ = 10;

// Needed for yBar to align this connector to its inner Y edge
yBarBasePlateConnectorWidth = _mountX;

// x and y faces of the yBarBasePlateMount_P block
_innerXFaceToScrew = 6;
_innerYFaceToScrew = 8;

_baseConnRecession = 3;
_baseConnY = 8;
_baseConnOuterXFaceToScrew = 2;

_heatSetX = _mountX - _innerXFaceToScrew;
_heatSetY = _mountY - _innerYFaceToScrew;

// TODO refactor this entire file
basePlateScrewMountToYBarXZFace = _heatSetY + joinCornerDepth; // Distance to the nearest YBar XZ face
basePlateScrewMountToYBarYZFace =  (yBarWidth+_heatSetX) - yBarBasePlateConnectorWidth;

module onYBarBasePlateConnectorPositive() {
  translate(v=[0,0,yBarWallThickness])
  intersection() {
    cube(size = [_mountX, _mountY, _mountZ]);
    halfspace(vpos=[0, -1, -1], p=[0, _mountY-1, _mountZ-1]);
  }
}

module onYBarBasePlateConnectorNegative() {

  translate(v=[_heatSetX, _heatSetY, m3HeatSetInsertSlotHeightSlacked + _baseConnRecession])
  mirror(v=[0,0,1])
  heatSetInsertSlot_N(rackFrameScrewType, topExtension=inf10);

  hull() {
    translate(v = [_heatSetX, _heatSetY, _baseConnRecession+overhangSlack])
    roundCutSlice(radius = heatSetInsertSlotRadiusSlacked(rackFrameScrewType)+radiusXYSlack);

    translate(v = [_heatSetX, _heatSetY, 0])
    roundCutSlice(radius = _baseConnY/2 + radiusXYSlack);
  }

}

module roundCutSlice(radius, length=inf50) {

  hull() {
    cylinder(r = radius, h = eps);

    translate(v = [length, -radius, 0])
    cube(size = [eps, radius*2, eps]);
  }
}
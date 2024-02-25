/* Some common screw dimensions and helper functions/modules */

include <../config/common.scad>
include <./math.scad>

/********************************************************************************/
// M3 dimensions
m3HoleRadiusSlack = radiusXYSlack;
m3Diameter = 3.0;
m3Radius = m3Diameter / 2.0;
m3RadiusSlacked = m3Radius + m3HoleRadiusSlack;

m3CounterSunkHeadRadius = 3;
m3CounterSunkHeadLength = 1.7;

m3HexNutWidthAcrossFlats = 5.41;
m3HexNutWidthAcrossCorners = FtoG(m3HexNutWidthAcrossFlats);
m3HexNutThickness = 2.2;

/********************************************************************************/
// M4 dimensions
m4HoleRadiusSlack = radiusXYSlack;
m4Diameter = 4.0;
m4Radius = m4Diameter / 2.0;
m4RadiusSlacked = m4Radius + m4HoleRadiusSlack;

m4CounterSunkHeadRadius = 4;
m4CounterSunkHeadLength = 2.3;

m4HexNutWidthAcrossFlats = 6.89;
m4HexNutWidthAcrossCorners = FtoG(m4HexNutWidthAcrossFlats);
m4HexNutThickness = 3.07;

/********************************************************************************/

function screwRadiusSlacked(screwType) =
  (screwType == "m3")
  ? m3RadiusSlacked
  : (screwType == "m4")
  ? m4RadiusSlacked
  : error("Unsupported screw type");

function hexNutThickness(screwType) =
  (screwType == "m3")
  ? m3HexNutThickness
  : (screwType == "m4")
  ? m4HexNutThickness
  : error("Unsupported screw type");


module counterSunkHead_N(screwType, screwExtension=0, headExtension=0) {

  if (screwType == "m3") {
    translate(v = [0, 0, -m3CounterSunkHeadLength])
    union() {
      cylinder(r1 = m3RadiusSlacked, r2 = m3CounterSunkHeadRadius, h = m3CounterSunkHeadLength);

      translate(v = [0, 0, -screwExtension])
      cylinder(r = m3RadiusSlacked, h = screwExtension);

      translate(v = [0, 0, m3CounterSunkHeadLength])
      cylinder(r = m3CounterSunkHeadRadius, h = headExtension);
    }
  } else if (screwType == "m4") {
    translate(v = [0, 0, -m4CounterSunkHeadLength])
    union() {
      cylinder(r1 = m4RadiusSlacked, r2 = m4CounterSunkHeadRadius, h = m4CounterSunkHeadLength);

      translate(v = [0, 0, -screwExtension])
      cylinder(r = m4RadiusSlacked, h = screwExtension);

      translate(v = [0, 0, m4CounterSunkHeadLength])
      cylinder(r = m4CounterSunkHeadRadius, h = headExtension);
    }
  } else {
    error("Unsupported screw type");
  }
}

module hexNut(screwType, center=true) {
  color([1, 1, 1])
  if (screwType == "m3") {
    translate(v = [0, 0,-m3HexNutThickness/2])
    difference() {
      cylinder(r=m3HexNutWidthAcrossCorners/2, h=m3HexNutThickness, $fn=6);
      cylinder(r=m3Radius,h=inf10, center=true);
    }
  } else if (screwType == "m4") {
    translate(v = [0, 0,-m4HexNutThickness/2])
    difference() {
      cylinder(r=m4HexNutWidthAcrossCorners/2, h=m4HexNutThickness, $fn=6);
      cylinder(r=m4Radius,h=inf10, center=true);
    }
  } else {
    error("Unsupported screw type");
  }
}

module hexNutPocket_N(screwType, openSide=true, backSpace=inf10, bridgeFront=false, bridgeBack=false ) {

  heightSlack = bridgeFront || bridgeBack ? overhangSlack: xySlack;

  if (screwType == "m3") {
    hexNutPocketHelper_N(m3RadiusSlacked, (m3HexNutWidthAcrossCorners+xySlack) / 2, m3HexNutThickness + heightSlack, openSide=openSide, backSpace=backSpace, bridgeFront=bridgeFront, bridgeBack=bridgeBack);
  } else if (screwType == "m4") {
    hexNutPocketHelper_N(m4RadiusSlacked, (m4HexNutWidthAcrossCorners+xySlack) / 2, m4HexNutThickness + heightSlack, openSide=openSide, backSpace=backSpace, bridgeFront=bridgeFront, bridgeBack=bridgeBack);
  } else {
    error("Unsupported screw type");
  }
}

module hexNutPocketHelper_N(innerRadius, widthAcrossCorners, thickness, openSide=true, backSpace=inf10, bridgeFront=false, bridgeBack=false) {

  assert (!(bridgeFront && bridgeBack));
  assert (!(openSide && bridgeFront));

  union() {
    hull() {
      // hexagonal prism representing where the nut should fit
      cylinder(r = widthAcrossCorners, h = thickness, center = true, $fn = 6);

      // negative volume for sliding in the nut
      translate(v = [inf50, 0, 0])
      cylinder(r = widthAcrossCorners, h = thickness, center = true, $fn = 6);
    }

    // negative volume for screw
    union() {
      // screw lead spacing
      translate(v = [0, 0, -backSpace])
      cylinder(r = innerRadius, h = backSpace, $fn = 32);

      cylinder(r=innerRadius, h=inf50, $fn=32);

      if (bridgeFront) {
        union() {
          // first bridge layer
          translate(v=[0,0,thickness/2 + defaultLayerHeight/2])
          cube(size=[2*innerRadius, GtoF(widthAcrossCorners)*2, defaultLayerHeight], center=true);
          // second bridge layer
          translate(v=[0,0,thickness/2 + defaultLayerHeight])
          cube(size=[2*innerRadius, 2*innerRadius, defaultLayerHeight], center=true);
        }
      }

      if (bridgeBack) {
        union() {
          // first bridge layer
          translate(v=[0,0,-(thickness/2 + defaultLayerHeight/2)])
          cube(size=[2*innerRadius, GtoF(widthAcrossCorners)*2, defaultLayerHeight], center=true);
          // second bridge layer
          translate(v=[0,0,-(thickness/2 + defaultLayerHeight)])
          cube(size=[2*innerRadius, 2*innerRadius, defaultLayerHeight], center=true);
        }
      }
    }

    if (openSide) {
      hull() {
        translate(v = [inf50, 0, 0])
        cylinder(r = innerRadius, h = inf50, $fn = 32);
        cylinder(r = innerRadius, h = inf50, $fn = 32);
      }
    }
  }
}

// Convert a regular hexagon widthAcrossFlats to widthAcrossCorners
function FtoG(widthAcrossFlats) = widthAcrossFlats * (2 / sqrt(3));

// Convert a regular hexagon widthAcrossCorners to widthAcrossFlats
function GtoF(widthAcrossCorners) = widthAcrossCorners * (sqrt(3) / 2);

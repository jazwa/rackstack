/* Some common screw dimensions and helper functions/modules */

include <./math.scad>
include <./common.scad>

/********************************************************************************/
// M3 dimensions
m3HoleRadiusSlack = 0.4; // higher slack for not-so straight heat set inserts
m3Diameter = 3.0;
m3Radius = m3Diameter / 2.0;
m3RadiusSlacked = m3Radius + m3HoleRadiusSlack;

m3CounterSunkHeadRadius = 3;
m3CounterSunkHeadLength = 1.7;

m3HexNutWidthAcrossFlats = 5.41;
m3HexNutWidthAcrossCorners = FtoG(m3HexNutWidthAcrossFlats);
m3HexNutThickness = 2.18;

m3HeatSetInsertSlotRadiusSlack = -0.1;
m3HeatSetInsertSlotHeightSlack = 0.5;

m3HeatSetInsertSlotRadius = 2.3;
m3HeatSetInsertSlotHeight = 5.7;

m3HeatSetInsertSlotRadiusSlacked = m3HeatSetInsertSlotRadius+m3HeatSetInsertSlotRadiusSlack;
m3HeatSetInsertSlotHeightSlacked = m3HeatSetInsertSlotHeight+m3HeatSetInsertSlotHeightSlack;

/********************************************************************************/
// M4 dimensions
m4HoleRadiusSlack = 0.15;
m4Diameter = 4.0;
m4Radius = m4Diameter / 2.0;
m4RadiusSlacked = m4Radius + m4HoleRadiusSlack;
m4HexNutWidthAcrossFlats = 6.89;
m4HexNutWidthAcrossCorners = FtoG(m4HexNutWidthAcrossFlats);
m4HexNutThickness = 3.07;

/********************************************************************************/

module heatSetInsertSlot_N(screwType, topExtension=inf50) {
  if (screwType == "m3") {
    union() {
      // actual slot for insert
      cylinder(h = m3HeatSetInsertSlotHeightSlacked, r = m3HeatSetInsertSlotRadiusSlacked);

      // extra space above slot to help with insertion
      translate(v=[0, 0, m3HeatSetInsertSlotHeightSlacked])
      cylinder(h = topExtension, r = m3HeatSetInsertSlotRadiusSlacked);
    }
  } else {
    error("Unsupported screw type");
  }
}

function screwRadiusSlacked(screwType) =
  (screwType == "m3")
  ? m3RadiusSlacked
  : (screwType == "m4")
  ? m4RadiusSlacked
  : error("Unsupported screw type");


module counterSunkHead_N(screwType, screwExtension=0, headExtension=0) {

  if (screwType == "m3") {
    translate(v=[0,0,-m3CounterSunkHeadLength])
    union() {
      cylinder(r1 = m3RadiusSlacked, r2 = m3CounterSunkHeadRadius, h = m3CounterSunkHeadLength);

      translate(v = [0, 0, -screwExtension])
      cylinder(r = m3RadiusSlacked, h = screwExtension);

      translate(v = [0, 0, m3CounterSunkHeadLength])
      cylinder(r = m3CounterSunkHeadRadius, h = headExtension);
    }
  } else {
    error("Unsupported screw type");
  }
}


module hexNutPocket_N(screwType) {
  if (screwType == "m3") {
    hexNutPocketHelper_N(m3RadiusSlacked, m3HexNutWidthAcrossCorners / 2 + 0.1, m3HexNutThickness + 0.2);
  } else if (screwType == "m4") {
    hexNutPocketHelper_N(m4RadiusSlacked, m4HexNutWidthAcrossCorners / 2 + 0.1, m4HexNutThickness + 0.2);
  } else {
    error("Unsupported screw type");
  }
}

module hexNutPocketHelper_N(innerRadius, widthAcrossCorners, thickness) {
  union() {
    hull() {
      // hexagonal cylinder representing where the nut should fit
      cylinder(r = widthAcrossCorners, h = thickness, center = true, $fn = 6);

      // negative volume for sliding in the nut
      translate(v = [inf50, 0, 0])
      cylinder(r = widthAcrossCorners, h = thickness, center = true, $fn = 6);
    }

    // negative volume for screw lead
    translate(v = [0, 0, - 10])
    cylinder(r = innerRadius, h = inf50, $fn = 32);

    hull() {
      translate(v = [inf50, 0, 0])
      cylinder(r = innerRadius, h = inf50, $fn = 32);
      cylinder(r = innerRadius, h = inf50, $fn = 32);
    }
  }
}

// Convert a regular hexagon widthAcrossFlats to widthAcrossCorners
function FtoG(widthAcrossFlats) = widthAcrossFlats * (2 / sqrt(3));

// Convert a regular hexagon widthAcrossCorners to widthAcrossFlats
function GtoF(widthAcrossCorners) = widthAcrossCorners * (sqrt(3) / 2);

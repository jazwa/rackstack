
/* Some common screw dimensions */


inf = 400; // basically infinity

/********************************************************************************/
// M3 dimensions

m3HoleRadiusSlack = 0.15;
m3Diameter = 3.0;
m3Radius = m3Diameter/2.0;

m3RadiusSlacked = m3Radius + m3HoleRadiusSlack;

// legacy TODO: replace
m3ptr = m3RadiusSlacked;

// NUTS!
m3HexNutWidthAcrossFlats = 5.41;
m3HexNutWidthAcrossCorners = FtoG(m3HexNutWidthAcrossFlats);

m3HexNutThickness = 2.18;

module m3HexNutPocketNegative() {
  hexNutPocketNegative(m3RadiusSlacked,
                       m3HexNutWidthAcrossCorners/2 + 0.1,
                       m3HexNutThickness + 0.2);
}


// TODO: remove test

*difference() {
  cube(size=[8,12,5], center=true);

  rotate(a=[0,0,20])
  m3HexNutPocketNegative();
}

*m3HexNutPocketNegative();


/********************************************************************************/
// M4 dimensions

m4HoleRadiusSlack = 0.15;
m4Diameter = 4.0;
m4Radius = m4Diameter/2.0;
m4RadiusSlacked = m4Radius + m4HoleRadiusSlack;

m4HexNutWidthAcrossFlats = 6.89;
m4HexNutWidthAcrossCorners = FtoG(m4HexNutWidthAcrossFlats);

m4HexNutThickness = 3.07;

module m4HexNutPocketNegative() {
  hexNutPocketNegative(m4RadiusSlacked,
                       m4HexNutWidthAcrossCorners/2 + 0.1,
                       m4HexNutThickness + 0.2);
}


// TODO: remove test

*difference() {
  translate(v=[0,1,0])
  cube(size=[10,12,6], center=true);

  rotate(a=[0,0,20])
  m4HexNutPocketNegative();
}

*m4HexNutPocketNegative();

/********************************************************************************/

// Convert a regular hexagon widthAcrossFlats to widthAcrossCorners
function FtoG(widthAcrossFlats) = widthAcrossFlats * (2/sqrt(3));  

// Convert a regular hexagon widthAcrossCorners to widthAcrossFlats
function GtoF(widthAcrossCorners) =  widthAcrossCorners * (sqrt(3)/2);


module hexNutPocketNegative(
  innerRadius,
  widthAcrossCorners,
  thickness)
{

  union() {

    hull() {
      // hexagonal cylinder representing where the nut should fit
      cylinder(r=widthAcrossCorners, h=thickness, center=true, $fn=6);

      // negative volume for sliding in the nut
      translate(v=[inf,0,0])
      cylinder(r=widthAcrossCorners, h=thickness, center=true, $fn=6);
    }

    // negative volume for screw lead
    translate(v=[0,0,-10])
    cylinder(r=innerRadius, h = inf, $fn=32);

    hull() {
     translate(v=[inf,0,0])
       cylinder(r=innerRadius, h = inf, $fn=32);
     cylinder(r=innerRadius, h = inf, $fn=32);
    }
  }
}


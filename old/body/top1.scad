include <../../common.scad>
include <../../math.scad>
include <../screws.scad>

$fn=64;

_height = 8;
_width = 210;
_depth = 200;


module _bodySilBase(width, depth, height, roundedPartHeight) {
  hull() {
    cube(size = [width, depth, height - roundedPartHeight]);
    minkowski() {
      translate(v = [roundedPartHeight, 0, height - roundedPartHeight])
        cube(size = [width-2*roundedPartHeight, depth, eps]);

      rotate(a = [90, 0, 0])
        cylinder(r = roundedPartHeight, h = eps);
    }
  }
}

module _bodySil(width, depth, height, roundedPartHeight, wallThickness, topThickness) {
  cornerSquareDim = 30;

  difference() {
    _bodySilBase(width, depth, height, roundedPartHeight);

    union() {
      translate(v = [wallThickness, cornerSquareDim, - topThickness])
        _bodySilBase(width - 2 * wallThickness, depth - 2 * cornerSquareDim, height, roundedPartHeight);

      translate(v=[cornerSquareDim, wallThickness, -topThickness])
        cube(size=[width-2*cornerSquareDim, depth-2*wallThickness, height]);
    }
  }
}

// Negative and centered on xy. Aligned with z=0 downwards
module _lugAndMagnet() {
  slack = 0.3;
  vSlack = 0.1;
  // lug
  translate(v=[0,0,-2.5])
  cube(size=[10+slack, 10+slack, 5+vSlack], center=true);

  // hole for magnet, no tolerance on
  translate(v=[0,0,-(5+vSlack+1.7)])
  cylinder(d=6+slack, h=1.7+vSlack);
}

module baseBody() {
  difference() {
    _bodySil(_width, _depth, _height, 4, 5, 2);

    _mid = [_width / 2, _depth / 2, _height];

    union() {

      for (i = mirror4XY(midpoint = _mid, offsetX = (_width / 2) - 15, offsetY = (_depth / 2) - 10)) {
        translate(v = i)
          _lugAndMagnet();
      }

      screwHolePositions = concat(
      mirror4XY(midpoint = _mid, offsetX = (_width / 2) - 25, offsetY = (_depth / 2) - 20),
      mirror4XY(midpoint = _mid, offsetX = (_width / 2) - 15, offsetY = (_depth / 2) - 20),
      mirror4XY(midpoint = _mid, offsetX = (_width / 2) - 25, offsetY = (_depth / 2) - 10)
      );

      for (i = screwHolePositions) {
        translate(v = i) {
          cylinder(r = m3RadiusSlacked, h = inf, center = true);

        }
      }

    }
  }
}


difference() {
  baseBody();

  union() {
    minkowski() {
      translate(v = [(_width - 130) / 2, (_depth - 150) / 2, - inf / 2])
        cube(size = [130, 150, inf]);

      cylinder(r = 5);
    }
  }
}


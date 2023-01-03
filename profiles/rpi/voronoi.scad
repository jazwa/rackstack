
// (c)2013 Felipe Sanches <juca@members.fsf.org>
// licensed under the terms of the GNU GPL version 3 (or later)

function normalize(v) = v / (sqrt(v[0] * v[0] + v[1] * v[1]));

//
// The voronoi() function generates a 2D surface, which can be provided to
// a) linear_extrude() to produce a 3D object
// b) intersection() to restrict it to a a specified shape -- see voronoi_polygon.scad
//
// Parameters:
//   points (required) ... nuclei coordinates (array of [x, y] pairs)
//   L                 ... the radius of the "world" (the pattern is built within this circle)
//   thickness         ... the thickness of the lines between cells
//   round             ... the radius applied to corners (fillet in CAD terms)
//   nuclei (bool)     ... show nuclei sites
//
// These parameters need to be kept more or less in proportion to each other, and to the distance
// apart of points in the point_set. If one or the other parameter is increased or decreased too
// much, you'll get no output.
//
module voronoi(points, L = 200, thickness = 1, round = 6, nuclei = true) {
	for (p = points) {
		difference() {
			minkowski() {
				intersection_for(p1 = points){
					if (p != p1) {
						angle = 90 + atan2(p[1] - p1[1], p[0] - p1[0]);

						translate((p + p1) / 2 - normalize(p1 - p) * (thickness + round))
						rotate([0, 0, angle])
						translate([-L, -L])
						square([2 * L, L]);
					}
				}
				circle(r = round, $fn = 20);
			}
			if (nuclei)
				translate(p) circle(r = 1, $fn = 20);
		}
	}
}

//
// The random_voronoi() function is the helper wrapper over the voronoi() core.
// It generates random nuclei site coordinates into the square area,
// passing other arguments to voronoi() unchanged.
//
// Parameters:
//   n                 ... number of nuclei sites to be generated
//   nuclei (bool)     ... show nuclei sites
//   L                 ... the radius of the "world" (the pattern is built within this circle)
//   thickness         ... the thickness of the lines between cells
//   round             ... the radius applied to corners (fillet in CAD terms)
//   min               ... minimum x and y coordinate for nuclei generation
//   max               ... maximum x and y coordinate for nuclei generation
//   seed              ... seed for the random generator (random if undefined)
//   center (bool)     ... move resulting pattern to [0, 0] if true
//
module random_voronoi(n = 20, nuclei = true, L = 200, thickness = 1, round = 6, min = 0, max = 100, seed = undef, center = false) {
	seed = seed == undef ? rands(0, 100, 1)[0] : seed;
	echo("Seed", seed);

	// Generate points.
	x = rands(min, max, n, seed);
	y = rands(min, max, n, seed + 1);
	points = [ for (i = [0 : n - 1]) [x[i], y[i]] ];
        
	// Center Voronoi.
	offset_x = center ? -(max(x) - min(x)) / 2 : 0;
	offset_y = center ? -(max(y) - min(y)) / 2 : 0;
	translate([offset_x, offset_y])
    
	voronoi(points, L = L, thickness = thickness, round = round, nuclei = nuclei);
}

// example with an explicit list of points:
point_set = [
	[0, 0], [30, 0], [20, 10], [50, 20], [15, 30], [85, 30], [35, 30], [12, 60],
	[45, 50], [80, 80], [20, -40], [-20, 20], [-15, 10], [-15, 50]
];
//voronoi(points = point_set, round = 4, nuclei = true);

module voronoi3u_N(h) {
  intersection() {
    translate(v=[10,5,0])
      cube(size=[160, 10, h]);
    translate(v=[20,-52,0])
      scale(v=[0.40,0.44,10])
      linear_extrude(height=10)
      random_voronoi(n = 128, round = 2, min = 0, max = 350, seed = 40, thickness=3.5, nuclei=false);
  }
}


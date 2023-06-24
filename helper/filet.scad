include <./math.scad>

module sphericalFiletEdge(width, depth, height, roundness) {
  rd = roundness;

  intersection() {
    minkowski() {
      sphere(r = rd);

      translate(v = [rd, rd, rd])
      cube(size = [width*2, depth - 2*rd, height*2]);
    }

    cube(size = [width, depth, height]);
  }
}

module cylindricalFiletEdge(width, depth, height, roundness) {
  rd = roundness;

  intersection() {
    minkowski() {
      rotate(a = [90, 0, 0])
      cylinder(r = rd, h = eps);

      translate(v = [rd, 0, rd])
      cube(size = [width, depth, height]);
    }

    cube(size = [width, depth, height]);
  }
}

module cylindricalFiletNegative(p0, p1, n, r) {
  l = norm(p1-p0);

  alignTo(p0=p0, p1=p1, p2=p0-n)
  rotate(a=[45,0,0])
  rotate(a=[0,90,0])
  zFiletNegative(length = l, r = r);
}

module zFiletNegative(length, r) {

  p1 = [0,0,0];
  p2 = [0,0,length];
  n1 = [-1,-1,0] / norm([-1,-1,0]);
  dr = sqrt(2*r^2);

  difference() {

    hull() {
      translate(v=[0,0,0])
      cube(size=[r,r,r]);

      translate(v = p2-[0,0,0.1])
      cube(size=[r,r,0.1]);

    }

    hull() {
      translate(v = p1-n1*dr)
      cylinder(r = r, h=0.0001, $fn = 32);


      translate(v = p2-n1*dr)
      cylinder(r = r, h=0.0001, $fn = 32);
    }
  }
}
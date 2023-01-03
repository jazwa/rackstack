
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
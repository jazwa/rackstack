
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

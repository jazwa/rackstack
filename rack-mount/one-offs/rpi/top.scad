
difference() {
  union() {
    cube(size=[67,95.7,1]);
    translate(v=[2,2,1])
    cube(size=[63.2,92,3]);
  }

  union() {
    translate(v=[3.5, 3.8,1])
      cube(size=[60,88,3]);

    for(i=[0:7]) {
      translate(v=[33.5,i*10 + 12,0])
      minkowski() {
        cylinder(h=1,r=1);
        cube(size=[50,5,10], center=true);
      }
    }
  }
}

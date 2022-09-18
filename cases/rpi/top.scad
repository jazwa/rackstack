

difference() {
  union() {
    cube(size=[67,93,1]);
    translate(v=[2, 2,1])
    cube(size=[63,88.8,2]);
  }

  union() {
    translate(v=[3.5, 3.5,1])
      cube(size=[60,85,3]);

    for(i=[0:7]) {
      translate(v=[33.5,i*10 + 10,0])
      minkowski() {
        cylinder(h=1,r=1);
        cube(size=[50,5,10], center=true);
      }
    }
  }
}

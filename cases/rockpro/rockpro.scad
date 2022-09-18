include <../common.scad>

// All coordinates are in [x,y], or [x,y,z] format

pcbDimensions = [79.41, 127.06]; // [x,y]
pcbThickness = 1.22;

// TODO move mount points
mountPoints = [[0,0,0], [0,118,0], [71.0,118, 0], [71.0,0,0]];

module mountPoints_N(cylHeight, cylRad1, cylRad2, cylFn, center) {
  for (i=[0:3]) {
    p = mountPoints[i];
    translate(v=[p[0], p[1], p[2]])
    cylinder(r1=cylRad1, r2=cylRad2, h=cylHeight, $fn=cylFn, center=center);
  }
  
}

module pcb() {
  cube(size=[pcbDimensions[0], pcbDimensions[1], pcbThickness]);
}

// defined on x-z plane, start at top of pcb
module frontFaceIOCutouts_N() {
  translate(v=[9,0,0])
    cube(size=[26.0,inf50,7.5]);

  translate(v=[35,0,0])
    cube(size=[35,inf50,17.9]);
}
module backFaceIOCutouts_N() {
  translate(v=[9,0,0])
    cube(size=[61,inf50,14]);
}


module cutoutProfile_N() {

  color([1,0,1])
  union() {
  mirror(v=[0,1,0])
    translate(v=[0,-1,pcbThickness])
    frontFaceIOCutouts_N();

  translate(v=[0,pcbDimensions[1]-1, pcbThickness])
  backFaceIOCutouts_N();
  }

  color([0.3,0.8,0.1])
  difference() {
    pcb();
    translate(v=[3.75, 3.75])
      mountPoints_N(10,2,2,10,true);
  }
}

cutoutProfile_N();


//mountPoints_N(10,2,2, true);





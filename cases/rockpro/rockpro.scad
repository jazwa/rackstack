


rockProMountDeltaXY = [[0,0,0], [118,0,0], [118,71.0,0], [0,71.0,0]];


module rockProMountPoints(cylHeight, cylRad1, cylRad2, cylFn, center) {
  
  for (i=[0:3]) {
    p = rockProMountDeltaXY[i];    
    translate(v=[p[0], p[1], p[2]])
    cylinder(r1=cylRad1, r2=cylRad2, h=cylHeight, $fn=cylFn, center=center);
  }
  
}


//rockProMountPoints(10,2,64, true);






slack = 0.5;
m3Diameter = 3.0;
m3Radius = m3Diameter/2.0;
m3ptr = m3Radius + slack;

legLength = 200;


module baseLeg(legLength) {
  cube(size=[3, 15, legLength]);
}


module leg() {
  difference() {
    baseLeg(legLength);

    union() {
      for (i = [0:18]) {
        translate(v=[0,10,(i+1)*10])
          rotate(a=[0,90,0])
          cylinder(h = 100, r = m3ptr, $fn=32, center=true);
      }

      translate(v=[0,10,(0+1)*10])
          rotate(a=[0,90,0])
          *cylinder(h = 100, r = m3ptr, $fn=32, center=true);

      translate(v=[0,10,(18+1)*10])
          rotate(a=[0,90,0])
          *cylinder(h = 100, r = m3ptr, $fn=32, center=true);
    }
  }
}

leg();

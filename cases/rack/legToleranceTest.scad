
slack = 0.5;
m3Diameter = 3.0;
m3Radius = m3Diameter/2.0;
m3ptr = m3Radius + slack;

legLength = 60;


module baseLeg(legLength) {
  difference() {
    cube(size=[16,16, legLength]);

    translate(v=[4,4,4])
    cube(size=[16, 16, legLength-2*4]);
  }
}


module leg(ui) {
  assert(ui > 0);

  legLength = 20 + (ui-1)*10;
  
  difference() {
    baseLeg(legLength);

    union() {
      for (i = [0:ui-1]) {
        translate(v=[0,10,(i+1)*10])
          rotate(a=[0,90,0])
          cylinder(h = 100, r = m3ptr, $fn=32, center=true);

        translate(v=[10,0,(i+1)*10])
          rotate(a=[90,0,0])
          cylinder(h = 100, r = m3ptr, $fn=32, center=true);
      }

      translate(v=[10,10,legLength/2])
      cylinder(h = legLength*2, r = m3ptr, $fn=32, center=true);
    }
  }
}

leg(18);

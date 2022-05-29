
$fn=64;

eps=0.1;

slack = 0.5;
m3Diameter = 3.0;
m3Radius = m3Diameter/2.0;
m3ptr = m3Radius + slack;

module baseFrame() {
  difference() {
    cube(size=[200,200,4], center=true);
    cube(size=[180,180,4], center=true);
  }

  translate(v=[90,90,0])
  cube(size=[20,20, 4],center=true);

  translate(v=[-90,90,0])
  cube(size=[20,20, 4],center=true);

  translate(v=[90,-90,0])
  cube(size=[20,20, 4],center=true);

  translate(v=[-90,-90,0])
  cube(size=[20,20, 4],center=true);
}

module lugBottom() {
  difference() {
    cube(size=[9.7,9.7,6], center=true);

    translate(v=[1,1,0])
    cube(size=[9.1,9.1,5+1], center=true);
  }
  
}


module base() {

  difference() {
    union() {
      translate(v=[0,0,4/2])
        baseFrame();


      translate(v=[-90,-90,-6/2])
        lugBottom();

      mirror(v=[1,0,0])
        translate(v=[-90,-90,-6/2])
        lugBottom();

      mirror(v=[0,1,0])
        translate(v=[-90,-90,-6/2])
        lugBottom();

      mirror(v=[1,1,0])
        translate(v=[-90,-90,-6/2])
        lugBottom();
    }

    union() {
      translate(v=[90,90,0]) 
      cylinder(h = 100, r = m3ptr, $fn=32, center=true);

      translate(v=[-90,90,0]) 
      cylinder(h = 100, r = m3ptr, $fn=32, center=true);

      translate(v=[90,-90,0]) 
      cylinder(h = 100, r = m3ptr, $fn=32, center=true);

      translate(v=[-90,-90,0]) 
      cylinder(h = 100, r = m3ptr, $fn=32, center=true);
      
    }
  }
}

base();

*lugBottom();



include <../../common.scad>
include <../screws.scad>

$fn=64;

module baseFrame() {
  difference() {
    cube(size=[200,200,4], center=true);
    cube(size=[180,180,4], center=true);
  }

  translate(v=[80,80,0])
  cube(size=[20,20, 4],center=true);

  translate(v=[-80,80,0])
  cube(size=[20,20, 4],center=true);

  translate(v=[80,-80,0])
  cube(size=[20,20, 4],center=true);

  translate(v=[-80,-80,0])
  cube(size=[20,20, 4],center=true);
}

module lugBottom() {
  difference() {
    cube(size=[9.7,9.7,6], center=true);

    translate(v=[2,2,0])
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
      translate(v=[80,80,0]) 
      cylinder(h = 100, r = m3ptr, $fn=32, center=true);

      translate(v=[-80,80,0]) 
      cylinder(h = 100, r = m3ptr, $fn=32, center=true);

      translate(v=[80,-80,0]) 
      cylinder(h = 100, r = m3ptr, $fn=32, center=true);

      translate(v=[-80,-80,0]) 
      cylinder(h = 100, r = m3ptr, $fn=32, center=true);
      
    }
  }
}

base();



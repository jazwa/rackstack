$fn=64;
include <./math.scad>

eps=0.1;

module leg() {
    mainLength = 80;
    upperDim = 20;
    innerDim = 10;
    
    translate(v=[0,0,mainLength/2]) {
      cube(size=[upperDim, upperDim, mainLength], center=true);
    
      translate(v=[0,0,mainLength/2 + innerDim/8-0.3])
        cube(size=[innerDim, innerDim, innerDim/4-0.5], center=true);

    }
}


module base() {

  difference() {
    union() {
      cube(size=[200,200,4], center=true);

      // legs
      for (i=mirror4XY(midpoint=[0,0,-2], offsetX=90, offsetY=90)) {
        translate(v=i)
          leg();
      }

      // base support
      translate(v=[0,0,4.5])
        cube(size=[200,5,5], center=true);

      rotate(a=[0,0,90])
        translate(v=[0,0,4.5])
        cube(size=[200,5,5], center=true);

      translate(v=[0,-98,4.5])
        cube(size=[200,4,5], center=true);

      rotate(a=[0,0,90])
        translate(v=[0,-98,4.5])
        cube(size=[200,4,5], center=true);

      rotate(a=[0,0,180])
        translate(v=[0,-98,4.5])
        cube(size=[200,4,5], center=true);

      rotate(a=[0,0,270])
        translate(v=[0,-98,4.5])
        cube(size=[200,4,5], center=true);

    }
        
    union() {

      
      // lug holes
      for (i=mirror4XY(midpoint=[0,0,0], offsetX=50, offsetY=50)) {
        for (j=mirror4XY(midpoint=i, offsetX=40, offsetY=40)) {
          translate(v=j)
            cube(size=[10+0.3,10+0.3,140], center=true);
        }
      }
      
      // decorative perforations
      for (i=mirror4XY(midpoint=[0,0,0], offsetX=50, offsetY=50)) {
        translate(v=i)
          minkowski() {
          cube(size=[30,30,50], center=true);
          cylinder(r=20, h=10);
        }
      }
          
    }
  }
}


base();



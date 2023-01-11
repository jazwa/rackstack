/*  Contains screw mounts to be used to fix risers and whatnot into plastic */

include <../common.scad>
include <./screws.scad>



// Heat set inserts:

// Useful references:
// https://hackaday.com/2019/02/28/threading-3d-printed-parts-how-to-use-heat-set-inserts/



// My knurled brass nut dimensions


m4NutDiameter = 6;
m4NutLength1 = 6;

m3NutDiameter = 4.9;
m3NutLength1 = 6;


module nut_N(diameter,length,edm,elm) {
  cylinder(h=(length + length*edm), d=(diameter + diameter*edm));
}

difference() {
  union() {
    cube(size=[30,30,2.5]);

    translate(v=[8,8,0])
    cylinder(h=8,d=8);

    translate(v=[22,8,0])
    cylinder(h=10,d=8);

    translate(v=[8,22,0])
    cylinder(h=8,d=10);

    translate(v=[22,22,0])
    cylinder(h=10,d=10);
  }

  union() {
    translate(v=[8,8,2])
      cylinder(h=6, d=6);

    translate(v=[22,8,4])
      cylinder(h=6,d=6);

    translate(v=[8,22,2])
    cylinder(h=6,d=6);

    translate(v=[22,22,3])
    cylinder(h=8,d=6);
  }

}



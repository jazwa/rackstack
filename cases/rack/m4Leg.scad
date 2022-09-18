include <../common.scad>
include <./screws.scad>


//slack = 0.5;
//m3Diameter = 3.0;
//m3Radius = m3Diameter/2.0;
//m3ptr = m3Radius + slack;

legWidth = 16;
legLength = 16;
legHeight = 60;

legFrontThickness = 6;
legSupportThickness = 4;

legWingThickness = 4;
legWingLength = 9;

// 9.5 to account for space for inserting hex nuts at the top
legWingWidth = 9.5+legSupportThickness;


module legWing() {
  difference() {
    cube(size=[legWingLength, legWingThickness, legWingWidth]);

    union() {
      translate(v=[4,0,10])
        rotate(a=[90,0,0])
        cylinder(r=m3RadiusSlacked, h=20, center=true);

      translate(v=[14,0,10])
        rotate(a=[90,0,0])
        cylinder(r=m3RadiusSlacked, h=20, center=true);
    }
  }
}

module base() {
    difference() {
      cube(size=[25,25,legWingThickness]);

      union() {
      translate(v=[20,20,0])
        cylinder(r=m3RadiusSlacked, h=100, center=true);

      translate(v=[10,10,0])
        cylinder(r=m3RadiusSlacked, h=100, center=true);

      translate(v=[20,10,0])
        cylinder(r=m3RadiusSlacked, h=100, center=true);

      translate(v=[10,20,0])
        cylinder(r=m3RadiusSlacked, h=100, center=true);
      }
      
    }
}

module baseLeg(legHeight) {
  union() {
    difference() {
      cube(size=[16,16, legHeight]);

      union() {
        translate(v=[4,6,0])
          cube(size=[16, 16, legHeight]);

        // compensate for differences between leg/wing thickness
        translate(v=[legSupportThickness,legSupportThickness,0])
          cube(size=[legWidth,legWidth,legSupportThickness+10]);

        translate(v=[legSupportThickness,legSupportThickness,legHeight-legWingWidth])
          cube(size=[legWidth,legWidth,legSupportThickness+10]);

      }
    }

    translate(v=[16,0,0])
      legWing();


    translate(v=[16,0,legHeight])
      mirror(v=[0,0,1]) {
      legWing();
    }

    mirror(v=[1,-1,0]) {
      translate(v=[16,0,0])
        legWing();


      translate(v=[16,0,legHeight])
        mirror(v=[0,0,1]) {
        legWing();
      }
    }

  }

  base();

  translate(v=[0,0,legHeight-legWingThickness])
    base();
}

*baseLeg(180);

module leg(ui) {
  assert(ui > 0);

  legLength = 20 + (ui-1)*10;
  
  difference() {
    baseLeg(legLength);

    union() {
        
      intersection() {
        union() {
          for (i = [1:ui-2]) {
            translate(v=[0,10,(i+1)*10])
              rotate(a=[0,90,0])
              *cylinder(h = 100, r = m3ptr, $fn=32, center=true);

            translate(v=[10,3,(i+1)*10])
              rotate(a=[90,-10,0])
              m4HexNutPocketNegative();
          }
        }      
        translate(v=[-1,-1,legWingWidth])
          cube(size=[1000,1000,legLength-2*legWingWidth]);
      }

      translate(v=[0,10,10])
        rotate(a=[0,90,0])
        cylinder(h = 100, r = m3ptr, $fn=32, center=true);

      translate(v=[0,10,ui*10])
        rotate(a=[0,90,0])
        cylinder(h = 100, r = m3ptr, $fn=32, center=true);


      translate(v=[10,0,10])
        rotate(a=[90,0,0])
        cylinder(h = 100, r = m3ptr, $fn=32, center=true);

      translate(v=[10,0,ui*10])
        rotate(a=[90,0,0])
        cylinder(h = 100, r = m3ptr, $fn=32, center=true);
    }
  }
}


//mirror(v=[1,0,0])
leg(20);

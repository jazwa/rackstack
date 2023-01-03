// test for screw tolerances

include <./rockpro.scad>;

include <../power/src/base.scad>;
$fn = 128;
outerD = 4.65;

innerD = 2.93;


module caseOuter() {
    rotate(a=[90,0,0])
    minkowski() {
        cube(size=[80,40,195], center=true);
        cylinder(h=0.00000000001, r=10);
    }
}

module caseInner() {
    translate(v=[0,0,2])
    rotate(a=[90,0,0])
    minkowski() {
        cube(size=[81.5,47,195+0.01], center=true);
        *cylinder(h=0.00000000001, r=5);
    }
}


module hgill(i) {
  minkowski() {
    *sphere(r=2);
              translate(v=[0,i*10,5])
              rotate(a=[30,0,0])
              cube(size=[200, 4, 30], center=true);
          }
    }

module caseShell() {
    difference() {
        caseOuter();

        union() {
          caseInner();

          // side perforations
          for (i=[-7:7]) {
              hgill(i=i);
          }

          // top perforations
          for (i=[-3:3]) {
            translate(v=[0,i*20,50])
            cube(size=[75,10,60], center=true);
          }

          // bottom perforations
          for (i=[2:4]) {
            translate(v=[0,i*20,-20])
            cube(size=[60,8,50], center=true);
          }

          for (i=[-4:0]) {
            translate(v=[0,i*20,-20])
            cube(size=[60,8,50], center=true);
          }
          
        }
    }
}


module faceMountDiffs() {
translate(v=[45,0,20])
rotate(a=[90,0,0])
cylinder(r=innerD/2,h=300, center=true);

translate(v=[45,0,-20])
rotate(a=[90,0,0])
cylinder(r=innerD/2,h=300, center=true);

translate(v=[-45,0,-20])
rotate(a=[90,0,0])
cylinder(r=innerD/2,h=300, center=true);

translate(v=[-45,0,20])
rotate(a=[90,0,0])
cylinder(r=innerD/2,h=300, center=true);
}


module caseWithMountHoles() {
  difference() {

    union() {
      caseShell();

      translate(v=[-35, 25,-27.5])
      rotate(a=[0,0,-90])
      rockProMountPoints(6, 3.8, 64, false);
    }

    union() {
      translate(v=[-35, 25,-27.5])
      rotate(a=[0,0,-90])
      rockProMountPoints(6, innerD/2, 64, false);

      faceMountDiffs();
    }
  }
}

*caseWithMountHoles();


module bottomTray() {
difference() {

union() {
intersection() {
  caseWithMountHoles();
  translate(v=[0,0,-115])
  cube(size=[500,500,200], center=true);
}

translate(v=[-45.5,0,-15])
rotate(a=[90,90,0])
joinTriangle(185);

translate(v=[45.5,0,-15])
rotate(a=[90,90,0])
joinTriangle(185);
}

  // bottom lugs
  union() {
    translate(v=[-40,-90,-29])
    cube(size=[10.2,10.2,2.5], center=true);

    translate(v=[40,-90,-29])
    cube(size=[10.2,10.2,2.5],center=true);

    translate(v=[40,90,-29])
    cube(size=[10.2,10.2,2.5],center=true);

    translate(v=[-40,90,-29])
    cube(size=[10.2,10.2,2.5],center=true);
  }
}
}


module topTray() {
  difference () {
    union() {
      difference() {
        caseWithMountHoles();
        translate(v=[0,0,-115])
          cube(size=[500,500,200], center=true);
      }
    }
    // bottom lugs
    union() {
      translate(v=[-40,-90,29])
        cube(size=[10.2,10.2,2.5], center=true);

      translate(v=[40,-90,29])
        cube(size=[10.2,10.2,2.5],center=true);

      translate(v=[40,90,29])
        cube(size=[10.2,10.2,2.5],center=true);

      translate(v=[-40,90,29])
        cube(size=[10.2,10.2,2.5],center=true);

      
      
      translate(v=[-45.5,0,-15])
        rotate(a=[90,90,0])
        scale(v=[1,0.9,1])
        joinTriangle(300);

      translate(v=[45.5,0,-15])
        rotate(a=[90,90,0])
        scale(v=[1,0.9,1])
        joinTriangle(300);
    }
  }
}

topTray();

// TODO make sure rail works!!!


scale(v=[1,0.9,1])
*joinTriangle(10);

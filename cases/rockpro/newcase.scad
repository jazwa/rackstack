
include <./rockpro.scad>;

include <../power/src/base.scad>;
$fn = 128;
outerD = 4.65;

innerD = 2.93;





module caseOuter() {
    rotate(a=[90,0,0])
    minkowski() {
        //translate(v=[-35, -15, -32.5])
        cube(size=[70,30,130], center=true);
        cylinder(h=0.00000000001, r=15);
    }
}

module caseInner() {
    translate(v=[0,0,0])
    rotate(a=[90,0,0])
    minkowski() {
        cube(size=[70,30,130+0.01], center=true);
        cylinder(h=0.00000000001, r=12);
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

  union() {
    

    
    difference() {
      caseOuter();

      union() {
        caseInner();

        // side perforations
        for (i=[-7:7]) {
          *hgill(i=i);
        }

        // top perforations
        for (i=[-2:2]) {
          translate(v=[0,i*20,50])
            cube(size=[50,8,50], center=true);
        }

        for (i=[-2:2]) {
          translate(v=[0,i*20,-20])
            rotate(a=[0,0,25])
            cube(size=[50,3,50], center=true);
        }
          
      }
    }
  }
}

module caseWithMountHoles() {
  difference() {

    union() {
      caseShell();

      translate(v=[-35, 59,-28])
      rotate(a=[0,0,-90])
      rockProMountPoints(5.0, 5.5, 2.5, 64, false);
      faceMountSupports();
    }

    union() {
      translate(v=[-35, 59,-29.5])
      rotate(a=[0,0,-90])
      rockProMountPoints(6.5, innerD/2, innerD/2, 64, false);

      faceMountDiffs();
    }
  }
}

module guideRail(x,y,z) {
  // gross
  cube(size=[y,z,x]);
}


module faceMountDiffs() {

  for (i = [-1,1]) {
    for (j = [-1,1]) {
      translate(v=[i*47,0,j*15]) {                  

        rotate(a=[90,0,0])
          translate(v=[0,0,93])
          *cylinder(r=innerD/2,h=12, center=true);
          
        rotate(a=[90,0,0])
          translate(v=[0,0,-93])
          *cylinder(r=innerD/2,h=12, center=true);

                  
          rotate(a=[90,0,0])
          translate(v=[0,0,90])
          cylinder(r=innerD/2,h=400, center=true);
      }

    }
  }
}

module faceMountSupports() {

  intersection() {
    caseOuter();
    for (i = [-1,1]) {
      for (j = [-1,1]) {
        translate(v=[i*47,0,j*15]) {

          
          rotate(a=[90,0,0])
          translate(v=[0,0,90])
          cylinder(r=innerD,h=400, center=true);

        }
      }
    }
  }
}

module bottomTray() {
difference() {

union() {
  translate(v=[-48,0,-11])
  cube(size=[4,130,4], center=true);

  translate(v=[48,0,-11])
  cube(size=[4,130,4], center=true);
intersection() {
  caseWithMountHoles();
  translate(v=[0,0,-110])
  cube(size=[500,500,200], center=true);
}



translate(v=[-50,65,-10+3])
rotate(a=[90,90,0])
guideRail(130,2,2);


translate(v=[48, 65, -10+3])
rotate(a=[90,90,0])
guideRail(130,2,2);


}

// bottom lugs
  union() {
    translate(v=[-35,-56.5,-30])
    *cube(size=[10.2,10.2,2.5], center=true);

    translate(v=[35,-56.5,-30])
    *cube(size=[10.2,10.2,2.5],center=true);

    translate(v=[35,56.5,-30])
    *cube(size=[10.2,10.2,2.5],center=true);

    translate(v=[-35,56.5,-30])
    *cube(size=[10.2,10.2,2.5],center=true);
  }


}

}



bottomTray();
*caseWithMountHoles();


*caseShell();

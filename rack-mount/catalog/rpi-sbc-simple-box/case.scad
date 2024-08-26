include <../../../config/common.scad>
include <../../../helper/common.scad>

// All coordinates are in [x,y], or [x,y,z] format
pcbDimensions = [56.0, 85.1]; // [x,y]
pcbThickness = 1.42;

// [+x, -x, +y, -y]
pcbCaseSpace = [5, 2, 5, 2];
pcbRise = 3;
caseWallThickness = 2;
caseBottomThickness = 2;
mountPointDiameter = 5;

mountPoints = [
    [3.65, 23.3,0],
    [3.65 + 49, 23.3,0],
    [3.65, 23.3 + 58,0],
    [3.65 + 49, 23.3 + 58,0]
];


module pcb() {
  cube(size=[pcbDimensions[0], pcbDimensions[1], pcbThickness]);
}

module pcbCaseBottom_() {
  translate(v=[-pcbCaseSpace[1]-caseWallThickness, -pcbCaseSpace[3]-caseWallThickness, -caseBottomThickness-pcbRise])
  difference() {
    cube(size=[
           pcbDimensions[0]+pcbCaseSpace[0]+pcbCaseSpace[1] + 2*caseWallThickness,
           pcbDimensions[1]+pcbCaseSpace[2]+pcbCaseSpace[3] + 2*caseWallThickness,
           26 // 3u case, subtracted for and other bullshit
           ]);
    translate(v=[caseWallThickness, caseWallThickness, caseBottomThickness])
    cube(size=[
           pcbDimensions[0]+pcbCaseSpace[0]+pcbCaseSpace[1],
           pcbDimensions[1]+pcbCaseSpace[2]+pcbCaseSpace[3],
           26 // 3u case, subtracted 4 for lid and bullshit
           ]);
  }
}

module pcbCaseWithRisers_() {
  union() {
    translate(v=[0,0,-pcbRise]){

      difference () {
        mountPoints_N(pcbRise, mountPointDiameter/1.5, mountPointDiameter/2, 32, false);
        mountPoints_N(pcbRise + 2, 1.95/2 - 0.05, 1.95/2 - 0.05, 32, false);
      }
    }
    pcbCaseBottom_();
  }
}


module cutoutProfileAirflow_N() {

  // bottom cutouts
  union() {
    for (i=[0:11]) {
      translate(v=[pcbDimensions[0]/2.0, i*6 + 10,0])
        minkowski() {
        cube(size=[30,1,20], center=true);
        cylinder(h=1,r=1);
      }
    }
  }

  // back cutout
  translate(v=[5,pcbDimensions[1]+5,-1])
    minkowski() {
      cube(size=[50,90,15], center=false);
      rotate(a=[90,0,0])
        cylinder(h=1,r=2);
  }

  // front cutout
  translate(v=[pcbDimensions[0],2.5,1])
  cube(size=[inf50, 80, 15]);
}

module mountPoints_N(cylHeight, cylRad1, cylRad2, cylFn, center) {
  for (i=[0:3]) {
    p = mountPoints[i];
    translate(v=[p[0], p[1], p[2]])
    cylinder(r1=cylRad1, r2=cylRad2, h=cylHeight, $fn=cylFn, center=center);
  }
  
}

// fucked up
module cutoutProfile_N() {
  color([1,0,1])
    union() {
    // front I/O
    mirror(v=[0,1,0])
      translate(v=[1, -eps*100, pcbThickness-4])
      cube(size=[58.0 + 0.1, inf50,  21 + 0.1]);

    // side I/O
    translate(v=[-48-3, (pcbDimensions[1]-54)-10, pcbThickness-4])
    cube(size=[inf50, 64, 19]);
  }

}


module mainCase() {
  difference() {

    union() {
      pcbCaseWithRisers_();

      // lugs
      // -4
      translate(v = [pcbDimensions[0]+caseWallThickness+pcbCaseSpace[0], -caseWallThickness-pcbCaseSpace[3], -pcbRise-
        caseBottomThickness])
        cube(size = [2, 5, 5]);

      // 87.1
      translate(v = [pcbDimensions[0]+caseWallThickness+pcbCaseSpace[0], pcbDimensions[1]+pcbCaseSpace[2]-5+
        caseWallThickness, -pcbRise-caseBottomThickness])
        cube(size = [2, 5, 5]);

      // -> 87.1 + 4 = 91.1
    }

    union() {
      cutoutProfile_N();
      cutoutProfileAirflow_N();
    }
  }
}

mainCase();

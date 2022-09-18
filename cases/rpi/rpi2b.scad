include <../common.scad>

// All coordinates are in [x,y], or [x,y,z] format

pcbDimensions = [56.0, 85.1]; // [x,y]
pcbThickness = 1.42;


// [+x, -x, +y, -y]
pcbCaseSpace = [5, 2, 2, 2];

pcbRise = 3;
caseWallThickness = 2;
caseBottomThickness = 2;


mountPointDiameter = 2.69;
mountPoints = [[3.65,23.30,0], [3.65,pcbDimensions[1]-3.65,0], [pcbDimensions[0]-3.65,23.30,0], [pcbDimensions[0]-3.65,pcbDimensions[1]-3.65,0]];

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
      mountPoints_N(pcbRise, mountPointDiameter, mountPointDiameter, 32, false);
      mountPoints_N(pcbRise+2, mountPointDiameter/2.5, mountPointDiameter/2.5, 32, false);
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

  // back cutouts
  for (i=[0:4]) {
    translate(v=[i*10 + 7,pcbDimensions[1],4])
    minkowski() {
      
        cube(size=[3,100,10], center=false);
        rotate(a=[90,0,0])
        cylinder(h=1,r=2);
      }
  }

  // front cutout
  translate(v=[pcbDimensions[0],2.5,1])
  cube(size=[inf50, 80, 15]);
}




difference() {

  union() {
  pcbCaseWithRisers_();

  // lugs
  translate(v=[pcbDimensions[0]+caseWallThickness+pcbCaseSpace[0],-caseWallThickness-pcbCaseSpace[3],-pcbRise-caseBottomThickness])
    cube(size=[2,5,5]);

  translate(v=[pcbDimensions[0]+caseWallThickness+pcbCaseSpace[0],pcbDimensions[1]+pcbCaseSpace[2]-5+caseWallThickness,-pcbRise-caseBottomThickness])
    cube(size=[2,5,5]);

  }

  union() {
    cutoutProfile_N();
    cutoutProfileAirflow_N();
  }
}


//cutoutProfileAirflow_N();



module mountPoints_N(cylHeight, cylRad1, cylRad2, cylFn, center) {
  for (i=[0:3]) {
    p = mountPoints[i];
    translate(v=[p[0], p[1], p[2]])
    cylinder(r1=cylRad1, r2=cylRad2, h=cylHeight, $fn=cylFn, center=center);
  }
  
}


*difference() {
  union () {
    pcb();
    mountPoints_N(7, mountPointDiameter/2.5, mountPointDiameter/2.5, 32, false);
    mountPoints_N(5, mountPointDiameter, mountPointDiameter, 32, false);
  }

  
}

module cutoutProfile_N() {


  color([1,0,1])
    union() {
    // front I/O
    mirror(v=[0,1,0])
      translate(v=[2, -eps*100, pcbThickness])
      cube(size=[52.0 + 0.1, inf50,  16.0 + 0.1]);

    // side I/O
    
    translate(v=[-48, (pcbDimensions[1]-54)-5, pcbThickness])
    cube(size=[inf50, 54, 8]);
  }

}

//cutoutProfile_N();
//pcb();


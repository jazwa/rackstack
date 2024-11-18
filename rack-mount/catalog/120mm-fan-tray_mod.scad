use <../tray/tray.scad>

/*
  Simple tray for a 120mm Case Fan.
  Not compatible with nano rack configuration.
  
  Please make sure to configure the correct rack frame dimensions in rackFrame.scad.
*/


difference () {
    bottomScrewTray (
        u = 2,
        trayWidth = 140,
        trayDepth = 140,
        trayThickness = 3,
        frontLipHeight = 26,
        backLipHeight = 6,
        mountPoints = [[15, 15], [15+105, 15],[15, 15+105], [15+105, 15+105]],
        frontThickness = 3,
        sideThickness = 3,
        mountPointElevation = 1,
        mountPointType = "m4",
        sideSupport = true,
        trayLeftPadding = 15
        );

/*Center Cutout*/
    translate(v=[67.5, 67.5, -50])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cylinder(h=60, r1=60, r2=60, $fn=75);
           
/*fan screw hole 1*/
    translate(v=[15, 15, -5])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cylinder(h=15.5, r1=2.5, r2=2.5, $fn=25);
            
/*fan screw hole 2*/
    translate(v=[15+105, 15, -5])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cylinder(h=15.5, r1=2.5, r2=2.5, $fn=25);
            
/*fan screw hole 3*/
    translate(v=[15+105, 15+105, -5])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cylinder(h=15.5, r1=2.5, r2=2.5, $fn=25);
         
/*fan screw hole 4*/
    translate(v=[15, 15+105, -5])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cylinder(h=15.5, r1=2.5, r2=2.5, $fn=25);
    }

//}

use <../tray/tray.scad>

/*
  Simple tray for a 120mm Case Fan.
  Not compatible with nano rack configuration.
  Designed to be mounted on the back in a reverse position, with the fan sitting on the outside of the case rather than the inside.
  Mesh Screens are advised on the fore and aft of the fan.
  Powered by USB to 3 or 2-pin connectors.
  MINIMUM HEIGHT IS 13 TOTAL U's, which is showcased as u = 12 in rackstack.
  
  Please make sure to configure the correct rack frame dimensions in rackFrame.scad.
*/


difference () {
    bottomScrewTray (
        u = 12,
        trayWidth = 130,
        trayDepth = 35,
        trayThickness = 3,
        frontLipHeight = 126,
        backLipHeight = 126,
       // mountPoints = [[15, 15], [15+105, 15],[15, 15+105], [15+105, 15+105]],
        frontThickness = 3,
        sideThickness = 3,
        mountPointElevation = 1,
        mountPointType = "m4",
        sideSupport = true,
        trayLeftPadding = 25
        );

translate (v=[-5,10,-5])
rotate (a=[90,0,0]) {
    // Center Cutout
    translate(v=[67.5, 67.5, -25])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cylinder(h=60, r1=60, r2=60, $fn=75);
           
    // fan screw hole 1
    translate(v=[15, 15, -25])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cylinder(h=65, r1=2.5, r2=2.5, $fn=25);
            
    // fan screw hole 2
    translate(v=[15+105, 15, -25])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cylinder(h=45, r1=2.5, r2=2.5, $fn=25);
            
    // fan screw hole 3
    translate(v=[15+105, 15+105, -25])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cylinder(h=65, r1=2.5, r2=2.5, $fn=25);
         
    // fan screw hole 4
    translate(v=[15, 15+105, -25])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cylinder(h=65, r1=2.5, r2=2.5, $fn=25);
    }
}
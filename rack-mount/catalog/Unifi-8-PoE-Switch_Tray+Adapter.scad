use <../tray/tray.scad>

/*
  Simple tray for a Unifi Lite 8PoE Switch.
  Included mounting adapter, mounting adapter seats two M3 Hex nuts using two M3x8 screws.
  DO NOT USE INCLUDED SCREWS FROM UNIFI, this will damage the switch.
  
  Please make sure to configure the correct rack frame dimensions in rackFrame.scad.
*/


///////////////////////////////////////
/////////// MOUNTING TRAY //////////// 
/////////////////////////////////////
difference () {
    bottomScrewTray (
        u = 3,
        trayWidth = 175,
        trayDepth = 110,
        trayThickness = 3,
        frontLipHeight = 7.5,
        backLipHeight = 7.5,
        mountPoints = [[54, 40], [54+60.325, 40]],
        frontThickness = 3,
        sideThickness = 3,
        mountPointElevation = 1,
        mountPointType = "m3",
        sideSupport = true,
        trayLeftPadding = 2.5
        );

    // Front Center Cube
    translate(v=[87.5, 20, -50])
        rotate(a=[90,0,45])
        rotate(a=[0,90,90])
        cube(size=[12,12,135]);
        
    // Center Right Cube
    translate(v=[58, 50, -50])
        rotate(a=[90,0,45])
        rotate(a=[0,90,90])
        cube(size=[12,12,135]);
        
    // Center Left Cube
    translate(v=[117.5, 50, -50])
        rotate(a=[90,0,45])
        rotate(a=[0,90,90])
        cube(size=[12,12,135]);
            
    // Rear Left Cube
    translate(v=[67.5, 60, -50])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cube(size=[12,12,135]);
        
    // Rear Center Cube
    translate(v=[87.5, 77, -50])
        rotate(a=[90,0,45])
        rotate(a=[0,90,90])
        cube(size=[12,12,135]);

    // Rear Right Cube
    translate(v=[103.5, 60, -50])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cube(size=[12,12,135]);
            
            
    // Side Front Right Cube
    translate(v=[132.5, 10, -50])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cube(size=[25,12,135]);
            
    // Side Front Left Cube
    translate(v=[37.5, 10, -50])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cube(size=[25,12,135]);

    // Side Rear Right Cube
    translate(v=[132.5, 65, -50])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cube(size=[25,12,135]);
            
    // Side Rear Left Cube
    translate(v=[38.5, 65, -50])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cube(size=[25,12,135]);
        
    }

///////////////////////////////////////
////////// MOUNTING ADAPTER ////////// 
/////////////////////////////////////

// Seat Teeth
translate (v= [0,1.5,0.1,]){
    translate(v=[54.25 + 15 -1.25, 5.5 + 13.51875, 10+2.25]) {
        cube(size=[1.5875, 6.5, 1.5875]);
    }
    translate(v=[54.25 + 20 -1.25, 5.5 + 13.51875, 10+2.25]) {
        cube(size=[1.5875, 6.5, 1.5875]);
    }
    translate(v=[54.25 + 25 -1.25, 5.5 + 13.51875, 10+2.25]) {
        cube(size=[1.5875, 6.5, 1.5875]);
    }

    translate(v=[54.25 + 15 -1.25 + 22, 5.5 + 13.51875, 10+2.25]) {
        cube(size=[1.5875, 6.5, 1.5875]);
    }
    translate(v=[54.25 + 20 -1.25 + 22, 5.5 + 13.51875, 10+2.25]) {
        cube(size=[1.5875, 6.5, 1.5875]);
    }
    translate(v=[54.25 + 25 -1.25 + 22, 5.5 + 13.51875, 10+2.25]) {
        cube(size=[1.5875, 6.5, 1.5875]);
    }
}

// Seat Key
difference () {
    translate(v=[54.25, 5.5 + 13.51875, 10+3.175]) {
        cube(size=[59.53125, 9.5, 1.5875]);
    }
    translate(v=[45 + 38.89375, 19, 12]) {
        cube(size=[1.5875, 10, 4.7625]);
    }
}

// Body
difference () {
    translate(v=[45, 28.5, 9 + 0.5125]) {
        cube(size=[77.7875, 23.01875, 5.7625 - 0.5125]);
    }


// Cut aways    
    translate(v=[45, 22, 0]) {    
    rotate(a=[0,0,45]){
        translate(v=[-.25, -.25, 9]) {
        cube(size=[9.7525, 9.7525, 10]);
    }
}
}  

     translate(v=[45+ 77.7875, 22, 0]) {    
    rotate(a=[0,0,45]){
        translate(v=[-.25, -.25, 9]) {
        cube(size=[9.7525, 9.7525, 10]);
    }
}
}   
// Screw holes 
    translate(v=[54, 40, -10]) {
            cylinder(h=65, r1=1.65, r2=1.65, $fn=25);
    }

    translate(v=[54+60.325, 40, -10]) {
            cylinder(h=65, r1=1.65, r2=1.65, $fn=25);
    }
    translate(v=[54+60.325, 40, 12]) {
            cylinder(h=65, r1=3.25, r2=3.25, $fn=6);
    }
    translate(v=[54, 40, 12]) {
            cylinder(h=65, r1=3.25, r2=3.25, $fn=6);
    }
}
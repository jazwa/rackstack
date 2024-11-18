use <../tray/tray.scad>

/*
  Simple tray for a MinisForum NAB9 mini PC.
  Not compatible with nano rack configuration.
    
  Please make sure to configure the correct rack frame dimensions in rackFrame.scad.
*/

difference () {
    bottomScrewTray (
        u = 5,
        trayWidth = 140,
        trayDepth = 140,
        trayThickness = 3,
        frontLipHeight = 3,
        backLipHeight = 5,
        mountPoints = [[20, 70], [20+95.25, 70]],
        frontThickness = 3,
        sideThickness = 3,
        mountPointElevation = 1,
        mountPointType = "m4",
        sideSupport = true,
        trayLeftPadding = 15
        );

    // Side perforations for airflow
    translate(v=[-4, 5, 18]) {
        rotate(a=[0,90,0])
        rotate(a=[0,0,45])
        cube(size=[18, 18, 155]);

    translate(v=[0, 28, -04])
        rotate(a=[0,90,0])
        rotate(a=[0,0,45])
        cube(size=[12,12,150]);
        
    translate(v=[0, 48, -06.5])
        rotate(a=[0,90,0])
        rotate(a=[0,0,45])
        cube(size=[8,8,150]);
        

    // Bottom perforations for airflow
    // Front Right Cube
    translate(v=[60, 40, -50])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cube(size=[12,12,135]);
        
    // Front Center Cube
    translate(v=[80, 35, -50])
        rotate(a=[90,0,45])
        rotate(a=[0,90,90])
        cube(size=[12,12,135]);

    // Front Left Cube
    translate(v=[95, 40, -50])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cube(size=[12,12,135]);
        
    // Center Right Cube
    translate(v=[50.5, 65, -50])
        rotate(a=[90,0,45])
        rotate(a=[0,90,90])
        cube(size=[12,12,135]);
        
    // Center Left Cube
    translate(v=[110, 65, -50])
        rotate(a=[90,0,45])
        rotate(a=[0,90,90])
        cube(size=[12,12,135]);
            
    // Rear Left Cube
    translate(v=[60, 75, -50])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cube(size=[12,12,135]);
        
    // Rear Center Cube
    translate(v=[80, 92, -50])
        rotate(a=[90,0,45])
        rotate(a=[0,90,90])
        cube(size=[12,12,135]);

    // Rear Right Cube
    translate(v=[96, 75, -50])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cube(size=[12,12,135]);
            
    // Far Rear Right Cube
    translate(v=[100, 110, -50])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cube(size=[12,25,135]);
            
    // Far Rear Left Cube
    translate(v=[67.5, 110, -50])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cube(size=[12,25,135]);
            
    // Far Front Right Cube
    translate(v=[100, 3, -50])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cube(size=[12,25,135]);
            
    // Far Front Left Cube
    translate(v=[67.5, 3, -50])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cube(size=[12,25,135]);
            
    // Side Front Right Cube
    translate(v=[125, 25, -50])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cube(size=[25,12,135]);
            
    // Side Front Left Cube
    translate(v=[30, 25, -50])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cube(size=[25,12,135]);

    // Side Rear Right Cube
    translate(v=[125, 80, -50])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cube(size=[25,12,135]);
            
    // Side Rear Left Cube
    translate(v=[30, 80, -50])
        rotate(a=[90,0,0])
        rotate(a=[0,90,90])
        cube(size=[25,12,135]);
        
    }

}

use <../tray/tray.scad>

/*
  Simple tray for a beelink mini-s series mini pc.

  Please make sure to configure the correct rack frame dimensions in rackFrame.scad.
*/

difference () {
    bottomScrewTray (
        u = 4,
        trayWidth = 130,
        trayDepth = 110,
        trayThickness = 3,
        frontLipHeight = 3,
        backLipHeight = 5,
        mountPoints = [[44, 8], [44+35, 8]],
        frontThickness = 3,
        sideThickness = 3,
        mountPointElevation = 1,
        mountPointType = "m3",
        sideSupport = true,
        trayLeftPadding = 15
        );


    // perforations for airflow
    translate(v=[-4, 5, 18]) {
        rotate(a=[0,90,0])
            rotate(a=[0,0,45])
            cube(size=[18, 18, 135]);


        translate(v=[0, 28, -4])
            rotate(a=[0,90,0])
            rotate(a=[0,0,45])
            cube(size=[12,12,135]);

    }

}

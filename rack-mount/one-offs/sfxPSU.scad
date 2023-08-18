
module sfxPowerSupply() {

    length = 125.0;
    width = 100.0;
    height = 64;
    screwD = 3.5;
    
    eps = 0.001;
    
    // body
    color([0,1,0]) cube(size=[length, width, height]);
    
    // main fan
    translate([62.5, 50,0])
    color([0,1,1])
    circle(d=88);
    
    
    // open faces
    translate([10,-eps, 7])
    color([0,1,1])
    cube(size=[length-20, eps, height-7]);

    
    // screw holes
    color([1,0,1])
    translate([length-6, eps, height-6])
    rotate(a=[90,0,0])
    circle(d=screwD);
    
    color([1,0,1])
    translate([6, eps, height-6])
    rotate(a=[90,0,0])
    circle(d=screwD);
    
    color([1,0,1])
    translate([6, eps, 6])
    rotate(a=[90,0,0])
    circle(d=screwD);
    
    color([1,0,1])
    translate([length-6, eps, 6])
    rotate(a=[90,0,0])
    circle(d=screwD);
        
    color([1,0,1])
    translate([6, eps, height-(6+25.5)])
    rotate(a=[90,0,0])
    circle(d=screwD);
    
    color([1,0,1])
    translate([length-6, eps, height-(6+25.5)])
    rotate(a=[90,0,0])
    circle(d=screwD);

    
}

sfxPowerSupply();
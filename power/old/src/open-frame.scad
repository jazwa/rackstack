totalLength = 200;
totalWidth = 200;
totalHeight = 75;


innerLength = 180;

basePlateHeight = 5;
topPlateHeight = 5;
convexity = 20;
$fn=64;

cDiameter = 10;
cRadius = cDiameter/2;
cRad = cRadius;
cPos1 = [cRad, cRad, 0];

cDelta = [
    // bottom
    [0,0,0],
    [cDiameter+innerLength, 0, 0],
    [cDiameter+innerLength,cDiameter+innerLength, 0],
    [0, cDiameter+innerLength, 0],
    // top
    [0,0,totalHeight-topPlateHeight],
    [cDiameter+innerLength, 0, totalHeight-topPlateHeight],
    [cDiameter+innerLength,cDiameter+innerLength, totalHeight-topPlateHeight],
    [0, cDiameter+innerLength, totalHeight-topPlateHeight]
];

function cPos(idx) = cPos1 + cDelta[idx];

module cyl(idx) {
    translate(v=cPos(idx)) cylinder(r=cRadius,h=idx < 4? basePlateHeight: topPlateHeight);
};


module bottomPlate() { 
    hull() { cyl(0); cyl(1); cyl(2); cyl(3);};
}
module topPlate() {
    hull() { cyl(4); cyl(5); cyl(6); cyl(7);};
};


module frontFace() {
hull() { cyl(0); cyl(4); cyl(1); cyl(5);};
};
module backFace() {
hull() { cyl(2); cyl(6); cyl(7); cyl(3);};
};


module frame() {
    bottomPlate();
    //topPlate();
    frontFace();
    backFace();
    
    // pillars
    hull() { cyl(0); cyl(4);};
    hull() { cyl(1); cyl(5);};
    hull() { cyl(2); cyl(6);};
    hull() { cyl(3); cyl(7);};
}


module sfxPowerSupply() {
    // corsair sf450
    length = 125.3;
    width = 100.2;
    height = 63.8;
    screwD = 3.5;
    
    eps = 0.001;
    
    // body
    color([0,1,0]) cube(size=[length, width, height]);
    
    // main fan
    color([0,1,1])
    translate([62.5, 50,0])
    circle(d=88);
    
    
    // open faces
    color([0,1,1])
    translate([10,-eps, 7])
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
    // atx connectors - NA
    
}

sfxPowerSupply();

module walls() {
difference() {
union() {
difference() {
difference() {
    frame();
    translate([62.5+37-10, 50+10,-25])
    cylinder(d=90, h=50);
};
    translate([47-10, -10, -10])
    cube(size=[106,20,100]);
};
translate(v=[25-10,0,-0])
cube(size=[totalLength*0.7, 10, 15]);
}
translate(v=[10,0,-0.2])
plate();
}
}



module plate() {
union() {
    translate(v=[totalLength-48, -1, 15])
    cube(size=[20, 8, 55]);
    
    translate([totalLength-38, 10, 60])
    rotate(a=[90,0,0])
    cylinder(d=11.2, h=50);

    translate([totalLength-38, 10, 42])
    rotate(a=[90,0,0])
    cylinder(d=11.2, h=50);

    translate([totalLength-38, 10, 25])
    rotate(a=[90,0,0])
    cylinder(d=11.2, h=50);
 };

};


module lightning() {
    linear_extrude(50)
    polygon(
        points = [
            [0,0],
            [12,10],
            [6,11],
            [10,16],
            [4,17],
            [-2,8],
            [4,7]
    ]);
}

module decal(numL, numW, sca) {
    dL = sca * 16;
    dW = sca * 18;
    
    for (i=[0:numL-1]) {
        for (j=[0:numW-1]) {
                translate(v=[i*dL,j*dW,0])
                scale(sca)
                lightning();
        }
        
    }
}

difference() {
    walls();
    rotate(a=[90,0,180])
    translate(v=[-161.5,10,180])
    decal(8, 3, 1.0);
};
translate([28, 16, 6])
*sfxPowerSupply();





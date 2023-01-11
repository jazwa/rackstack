
include <./sfx-psu.scad>;

$fn=64;

eps=0.1;

module gill(he, isCenter) {
   minkowski() {
    cylinder(h = 1, r1 = 2, r2 = 2);
    cube(size=[he, 3.5, 6], center=isCenter);
   } 
}


module basBarInsert() {
    mainLength = 10;
    upperDim = 20;
    innerDim = 10;
    
    translate(v=[0,0,mainLength/2]) {
        difference() {
            cube(size=[upperDim, upperDim, mainLength], center=true);
    
            translate(v=[0,0,mainLength/2 - innerDim/4])
            cube(size=[innerDim, innerDim, innerDim/2], center=true);
        }
    }
}


module topBarInsert(slack) {
    innerDim = 10+slack;
    
    translate(v=[0,0,innerDim/4])
    cube(size=[innerDim, innerDim, innerDim/2], center=true);

}

*topBarInsert(-0.6);


module base() {
    translate(v=[90,90,-2.5])
    basBarInsert();

    translate(v=[-90,90,-2.5])
    basBarInsert();

    translate(v=[90,-90,-2.5])
    basBarInsert();

    translate(v=[-90,-90,-2.5])
    basBarInsert();
    
    difference() {
        difference() {
            cube(size=[200,200,5], center=true);
        
            minkowski() {
                translate(v=[17,-45,0])
                cube(size=[90, 90, 6], center=true);
            
                cylinder(h = 1, r1 = 2, r2 = 2);
            }
        }
        
        union() {
        
            for (i = [0:12] ) {
                rotate(a=[0,0,90])
                translate(v=[50,72.5 - i*12,0])
                gill(he=65, isCenter=true);
            }
        
            for (i = [0:1] ) {
                rotate(a=[0,0,90])
                translate(v=[-40,72.5 - i*12,0])
                gill(he=80, isCenter=true) ;
            }
        }
    }
}


module top() {
    
    difference() {
        union() {
            translate(v=[90,90,-0.2])
            topBarInsert(-0.6);

            translate(v=[-90,90,-0.2])
            topBarInsert(-0.6);
    
            translate(v=[90,-90,-0.2])
            topBarInsert(-0.6);
    
            translate(v=[-90,-90,-0.2])
            topBarInsert(-0.6);    
    
            difference() {
        
            translate(v=[0,0,-1.5])
            cube(size=[200,200,3], center=true);

            union() {
        
            for (i = [0:12] ) {
                rotate(a=[0,0,90])
                translate(v=[45,72.5 - i*12,0])
                gill(he=75, isCenter=true);
            }
        
            for (i = [0:12] ) {
                rotate(a=[0,0,90])
                translate(v=[-45,72.5 - i*12,0])
                gill(he=75, isCenter=true) ;
            }
            }
            }
        }
        union() {
            translate(v=[90,90,-6])
            topBarInsert(0.5);

            translate(v=[-90,90,-6])
            topBarInsert(0.5);
    
            translate(v=[90,-90,-6])
            topBarInsert(0.5);
    
            translate(v=[-90,-90,-6])
            topBarInsert(0.5);    
        }
    }
}

base();
*top();


legInsertInnerSlack = 0.4;

module legInsert(length, railSlack) {
    iS = 10-legInsertInnerSlack;

    difference() {
        union() {
            cube(size=[20,20,length], center=true);
    
            translate(v=[0,0,iS/2-legInsertInnerSlack/2])
            cube(size=[iS, iS, length], center=true);
        }
        
        union() {
            // slot
            translate(v=[0,0,-length/2 ])
            cube(size=[10, 10, 10], center=true);
            
            // linear sliding joins for walls
            for (i=[0:3]) {
                rotate(a=[0,0,90*i])
                translate(v=[10,0,-5])
                cylinder(length*2,5+railSlack,5+railSlack,$fn=3, center=true);
                
            }
            
            rotate(a=[0,0,90])
            translate(v=[10,0,-5])
            cylinder(length*2,5,5,$fn=3, center=true);
            
            rotate(a=[0,0,180])
            translate(v=[10,0,-5])
            cylinder(length*2,5,5,$fn=3, center=true);
            
            rotate(a=[0,0,270])
            translate(v=[10,0,-5])
            cylinder(length*2,5,5,$fn=3, center=true);
        }
    }
}
*cylinder(20,4,5,$fn=3);


module joinTriangle(length) {

    translate(v=[-10,0,0])
    difference() {
        translate(v=[5.5, -4.5, -length/2])
        cube(size=[8,9,length]);
        
        legInsert(length=length+eps, railSlack=-0.35);
    }
}

module sidePlate() {
    
    translate(v=[0,35,-5])
    rotate(a=[0,-90,-90])
    union() {
        translate(v=[0,180,0])
        joinTriangle(length=70);
    
        joinTriangle(length=70);

        translate(v=[2,-10,-40])
        cube(size=[3,200,75]);
    }
}

module frontPlateHoled() {
difference() {
    sidePlate();
    
    intersection() {
        translate(v=[5,0,-25])
        cube(size=[170,65,50]);

        union() {
            for (i=[0:11]) {
                translate(v=[20+i*17, 0, 0])
                rotate(a=[0,0,45])
                cube(size=[8,1000,40], center=true);
            }
        }
    }
}
}


module backPlateHoled() {
    difference() {
    sidePlate();
    
    union() {
        translate(v=[20,5,-25])
        cube(size=[106,53,50]);

        translate(v=[16,27.2,-50])
        cylinder(h=100, r1=2, r2=2);
        
        translate(v=[16,52.8,-50])
        cylinder(h=100, r1=2, r2=2);
        
        translate(v=[16,0.85,-50])
        cylinder(h=100, r1=2, r2=2);
        

        translate(v=[129.4,27.2,-50])
        cylinder(h=100, r1=2, r2=2);
        
        translate(v=[129.4,0.85,-50])
        cylinder(h=100, r1=2, r2=2);
        
        translate(v=[129.4,52.8,-50])
        cylinder(h=100, r1=2, r2=2);
        
        
        
        // power out
        
        translate(v=[150,50,-50])
        cylinder(h=100, r1=5.6, r2=5.6);

        translate(v=[160,15+17.5,-50])
        cylinder(h=100, r1=5.6, r2=5.6);

        translate(v=[150,15,-50])
        cylinder(h=100, r1=5.6, r2=5.6);
        
    }
}
}


// messed up placement of the holes, mirroring as hack to approx solve
module mirroredBackPlateHoled() {
    
    mirror(v=[0,0,1])
    translate(v=[0,0,-10])
    backPlateHoled();
}


module supportLBracket(length, h1, h2, thickness) {
    
    numSegments = 2;
    
    
    module triangleSupport() {
        
       hull() {
            
            translate(v=[0, h1-thickness, thickness-eps])
            cube(size=[thickness, thickness, eps]);
            
            translate(v=[0, 0, h2-eps])
            cube(size=[thickness, thickness, eps]);
            
            translate(v=[0, 0, 0])
            cube(size=[thickness, thickness, eps]);
        }
    }  
    
    union() {
        difference() {
            cube(size=[length, h1, h2]);

            translate(v=[-eps,thickness, thickness])
            cube(size=[length+2*eps, h1+2*eps, h2+2*eps]);
        }
        
        
        for (i=[0:numSegments]) {
            translate(v=[((length-thickness)/numSegments)*i, 0,0])
            triangleSupport();
        }


    }
}

*supportLBracket(35, 8, 8, 1.5);
*mirroredBackPlateHoled();

translate(v=[10,-5,-1])
rotate(a=[-90,0,0])
*sfxPowerSupply();



include <./sfx-psu.scad>;

$fn=64;


module gill(he) {
   minkowski() {
    cylinder(h = 1, r1 = 2, r2 = 2);
    cube(size=[he, 3.5, 6], center=true);
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
                gill(he=65);
            }
        
            for (i = [0:1] ) {
                rotate(a=[0,0,90])
                translate(v=[-40,72.5 - i*12,0])
                gill(he=80) ;
            }
        }
    }
}

translate(v=[-46,-95,0])
*sfxPowerSupply();




*base();


legInsertInnerSlack = 0.4;

module legInsert(length) {
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
            translate(v=[10,0,-5])
            cylinder(length*2,5,5,$fn=3, center=true);
            
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

legInsert(length=70);


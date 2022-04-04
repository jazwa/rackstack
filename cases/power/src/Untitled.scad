// test for screw tolerances


$fn = 128;
outerD = 4.65;

innerD = 2.95;

*difference() {
    cube(size=[10,50,10]);
    union() {
        translate(v=[5,10,-1])
        cylinder(h=30,r=innerD/2-0.2);
        
        translate(v=[5,25,-1])
        cylinder(h=30,r=innerD/2);
        
        translate(v=[5,40,-1])
        cylinder(h=30,r=innerD/2+0.2);
    }
}


module caseOuter() {
    rotate(a=[90,0,0])
    minkowski() {
        cube(size=[90,40,195], center=true);
        cylinder(h=0.00000000001, r=10);
    }
}

module caseInner() {
    translate(v=[0,0,-2])
    rotate(a=[90,0,0])
    minkowski() {
        cube(size=[90,47,195+0.01], center=true);
        *cylinder(h=0.00000000001, r=5);
    }
}

module caseShell() {
    difference() {
        caseOuter();
        caseInner();
    }
}





caseShell();
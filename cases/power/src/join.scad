/*
// from corner cube
frameExtrusions = [
    0,      // north
    0,      // east
    10,     // south
    10,     // west
    0,      // up
    0       // down
];

unitVectors = [
    [ 1,  0,  0], // north
    [ 0,  1,  0], // east
    [-1,  0,  0], // south
    [ 0, -1,  0], // west
    [ 0,  0,  1], // up
    [ 0,  0, -1]  // down
];
*/

cornerCubeDimensions = [10,10,10];


slack = 0.45            ;

legOuterDim = [10,10,10];
legInnerDim = [5,5,5];


//
module leg() {
    difference() {
        cube(size=legOuterDim, center=true);
        translate(v=[0,0,(legOuterDim[2]-legInnerDim[2])/2])
        cube(size=[legInnerDim[0]+slack, legInnerDim[1]+slack, legInnerDim[2]+slack], center=true); 
    }
}


module threeJoin() {
// corner cube
    
difference() {
    rotate(a=90, v=[0,0,1])
union() {
cube(size=cornerCubeDimensions, center=true);

translate(v=[0,0,10])
leg();

translate(v=[0,-10,0])
rotate(a=[90,0,0])
leg();

translate(v=[10,0,0])
rotate(a=[0,90,0])
leg();
}
    translate(v=[10,10,-20])
    rotate(a=135, v=[1,-1,0])
    cube(size=[100,100,100]);

}
    
}

    translate(v=[10,10,-20])
    rotate(a=135, v=[1,-1,0])
    *cube(size=[100,100,100]);

module frameBar() {
    cube(size=[10,10,10], center=true);

    translate(v=[7.5,0,0])
    cube(size=[5,5,5], center=true);
    
    translate(v=[-7.5,0,0])
    cube(size=[5,5,5], center=true);
}

translate(v=[0,0,5])
rotate(a=45, v=[1,-1,0])
*threeJoin();

frameBar();

oslack = 0.05;
module old() {
cube(size=[160,10,10], center=true);

translate(v=[82.5,0,0])
cube(size=[5+oslack,5+oslack,5+oslack], center=true);
    
translate(v=[-82.5,0,0])
cube(size=[5+oslack,5+oslack,5+oslack], center=true);

}



module baseBar() {
    
    
}
//old();

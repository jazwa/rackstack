
eps=0.01;
vU = 2;
uHeight = 10;

plateScrewDiffV = uHeight*vU;
plateScrewDiffH = 180;

plateScrewToHEdge = 4.5;
plateScrewToVEdge = 5.5;

frontPlateThickness = 3;

frontPlateV = plateScrewDiffV + 2*plateScrewToHEdge;
frontPlateH = plateScrewDiffH + 2*plateScrewToVEdge;

//////////////////////////////////////////////////////

trayOuterHeight = 28;
trayOuterWidth = 168;
trayOuterDepth = 130;

trayBottomThickness = 2;
traySideThickness = 3;
trayFrontThickness = 2;


trayInnerWidth = trayOuterWidth - 2*traySideThickness;
trayInnerDepth = trayOuterDepth - trayFrontThickness;
trayInnerHeight = trayOuterHeight - trayBottomThickness;

module _trayBody() {

    difference() {
        cube(size = [trayOuterWidth, trayOuterDepth, trayOuterHeight]);

        union() {
            translate(v = [traySideThickness, trayFrontThickness, trayBottomThickness])
                cube(size = [trayInnerWidth + eps, trayInnerDepth + eps, trayInnerHeight + eps]);


            translate(v=[0,0, trayOuterHeight])
                rotate(a=[-atan(trayInnerHeight/trayOuterDepth),0,0])
                    cube(size=[trayOuterWidth+eps, 2*trayOuterDepth+eps, trayInnerHeight+eps]);

            translate(v=[5+traySideThickness,0,trayBottomThickness])
            cube(size=[trayInnerWidth-10, trayFrontThickness+eps, trayOuterHeight]);
        }
    }
}

// todo make a nice module for this (triangular prism)
module _sideHole_N() {
    scale(v=[2,0.65,0.65])
        difference () {
            cube(size = [trayOuterWidth, trayOuterDepth, trayOuterHeight]);
            translate(v = [0, 0, trayOuterHeight])
                rotate(a = [- atan(trayInnerHeight / trayOuterDepth), 0, 0])
                    cube(size = [trayOuterWidth + eps, 2 * trayOuterDepth + eps, trayInnerHeight + eps]);
        }
}


module trayBody() {
    union() {
        difference() {
            _trayBody();
            union() {
                // bottom holes
                for (i = [0:7]) {
                    translate(v = [35, i * 15 + 10, - eps])
                        *cube(size = [100, 5, 10]);
                }
                translate(v=[-10,5,5])
                _sideHole_N();
            }
        }

        // lugs for front
        translate(v=[0,-2,0])
            cube(size=[5,2,5]);
        translate(v=[trayOuterWidth-5,-2,0])
            cube(size=[5,2,5]);
    }
}




//trayBody();


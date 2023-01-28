include <./config.scad>
include <../helper/screws.scad>
include <../helper/halfspace.scad>
include <../misc/magnet.scad>
include <./sharedVariables.scad>

sideWallConnectorSlotWidth = 7;

sideWallConnW = 7;
sideWallConnD = 20;
sideWallConnH = 2;
sideWallConnLugDepression = sideWallConnH;

yBarScrewHoleToOuterYEdge = 3.5;
yBarScrewHoleToFrontXEdge = 16;

magnetFaceToSideWallConnOuterYEdge = 2;
magnetMountExtraRadius = magnetRSlacked + 1;

innerSideWallToYBarMagnetConn = magnetFaceToSideWallConnOuterYEdge + sideWallSlotToOuterYEdge - sideWallThickness;

hingePoleR = 2.5;
hingePoleH = 3;
hingeHoleR = hingePoleR + 0.5;

hingePoleToConnectorOuterYZFace = hingePoleR/2;

module sideWallConnector_N() {
    translate(v = [0, 0, -sideWallConnLugDepression])
    cube(size = [sideWallConnW, sideWallConnD, sideWallConnLugDepression]);

    translate(v = [yBarScrewHoleToOuterYEdge, yBarScrewHoleToFrontXEdge, -(m3HeatSetInsertSlotHeightSlacked+sideWallConnLugDepression)])
    heatSetInsertSlot_N(rackFrameScrewType);
}

module sideWallConnectorMagnet() {

    applyYBarScrewMount()
    applyMagnetMount()
    base();

    module base() {
        intersection() {
            cube(size = [sideWallConnW, sideWallConnD, sideWallConnLugDepression]);

            // TODO: pattern for this? beef up mirror4XY?
            cVal = 0.5;
            halfspace(p=[0,cVal,0], vpos=[0,1,1]);
            halfspace(p=[cVal,0,0], vpos=[1,0,1]);
            halfspace(p=[sideWallConnW-cVal,0,0], vpos=[-1,0,1]);
            halfspace(p=[0,sideWallConnD-cVal,0], vpos=[0,-1,1]);
        }
    }

    module applyYBarScrewMount() {
        apply_n() {
            translate(v = [yBarScrewHoleToOuterYEdge, yBarScrewHoleToFrontXEdge, sideWallConnLugDepression])
            counterSunkHead_N(rackFrameScrewType, headExtension = eps, screwExtension = inf10);

            children(0);
        }
    }

    // TODO: clean up
    module applyMagnetMount() {
        apply_p() {
            difference() {
                hull() {
                    translate(v = [0, 4, magnetMountExtraRadius+sideWallConnH])
                    rotate(a = [0, 90, 0])
                    cylinder(r = magnetMountExtraRadius, h = sideWallConnW-magnetFaceToSideWallConnOuterYEdge);

                    translate(v = [0, 0, sideWallConnH])
                    cube(size = [sideWallConnW-magnetFaceToSideWallConnOuterYEdge, 2*magnetMountExtraRadius, eps]);
                }

                translate(v = [sideWallConnW-(magnetFaceToSideWallConnOuterYEdge+magnetHSlacked), 4, 6])
                rotate(a = [0, 90, 0])
                cylinder(r = magnetRSlacked, h = magnetHSlacked);
            }

            children(0);
        }
    }
}

module sideWallConnectorHinge() {

    applyHingePole()
    applyYBarScrewMount()
    base();

    module base() {
        intersection() {
            cube(size = [sideWallConnW, sideWallConnD, sideWallConnLugDepression]);

            // TODO: pattern for this? beef up mirror4XY?
            cVal = 0.5;
            halfspace(p=[0,cVal,0], vpos=[0,1,1]);
            halfspace(p=[cVal,0,0], vpos=[1,0,1]);
            halfspace(p=[sideWallConnW-cVal,0,0], vpos=[-1,0,1]);
            halfspace(p=[0,sideWallConnD-cVal,0], vpos=[0,-1,1]);
        }
    }

    module applyHingePole() {
        apply_p() {
            translate(v = [sideWallConnW-hingePoleR, hingePoleR, sideWallConnH])
            cylinder(r = hingePoleR, h = hingePoleH);

            children(0);
        }
    }


    module applyYBarScrewMount() {
        apply_n() {
            translate(v = [yBarScrewHoleToOuterYEdge, yBarScrewHoleToFrontXEdge, sideWallConnLugDepression])
            counterSunkHead_N(rackFrameScrewType, headExtension = eps, screwExtension = inf10);

            children(0);
        }
    }
}


// TODO: better naming
module sideWallConnectorMagnetSide() {
    // oriented so that the xy face is the side wall's inner face
    difference() {
        cylinder(r1=magnetMountExtraRadius+2 ,r2 = magnetMountExtraRadius, h = innerSideWallToYBarMagnetConn);

        translate(v=[0, 0, innerSideWallToYBarMagnetConn-magnetHSlacked])
        cylinder(r = magnetRSlacked, h = magnetHSlacked);
    }
}
*sideWallConnector_N();
*sideWallConnectorMagnet();
*sideWallConnectorMagnetSide();
sideWallConnectorHinge();

//counterSunkHead_N(rackFrameScrewType,screwExtension=10);

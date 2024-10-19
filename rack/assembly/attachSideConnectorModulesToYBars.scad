include <./common.scad>
use <./screwXBarAndYBar.scad>
use <./addMagnetsToMagnetModules.scad>


/*
  NOTE You only need to do this step if the `fixedSideModules` option is set to false. 
*/

$vpt = [116,90,18];
$vpr = [56,0,42];
$vpd = 550;
$vpf = 22.50;

attachSideConnectorModulesToYBars(at=$t);

module attachSideConnectorModulesToYBars(at=0) {
    elevation = lerp(a=8, b=0, t=at);

    // side module to front corner ybar
    function sideModuleTrans(t=0) =
        translate(v=[sideWallConnW,0,t-sideWallConnLugDepression])
        * yBarSideModuleConnectorTrans
        * mirror(v=[1,0,0]); // mirror for magnetModule

    screwXBarAndYBar(at=1);

    if (!fixedSideModules) {
        multmatrix(sideModuleTrans(elevation))
            union() {


            addMagnetsToMagnetModules(at=1);


            translate(v=[yBarScrewHoleToOuterYEdge,yBarScrewHoleToFrontXEdge,sideWallConnLugDepression + 2*elevation])
                caseScrewShort();
        }

        multmatrix(xBarSpaceToYBarSpace * xBarMirrorOtherCornerTrans * yBarSpaceToXBarSpace * sideModuleTrans(elevation))
            union() {

            addMagnetsToMagnetModules(at=1);


            translate(v=[yBarScrewHoleToOuterYEdge,yBarScrewHoleToFrontXEdge,sideWallConnLugDepression + 2*elevation])
                caseScrewShort();
        }

        multmatrix(yBarMirrorOtherCornerTrans * sideModuleTrans(elevation))
            union() {

            if (!plasticMask) {
                hingeModule();
            }

            translate(v=[yBarScrewHoleToOuterYEdge,yBarScrewHoleToFrontXEdge,sideWallConnLugDepression + 2*elevation])
                caseScrewShort();
        }

        multmatrix(xBarSpaceToYBarSpace * xBarMirrorOtherCornerTrans * yBarSpaceToXBarSpace * yBarMirrorOtherCornerTrans * sideModuleTrans(elevation))
            union() {
            if (!plasticMask) {
                hingeModule();
            }

            translate(v=[yBarScrewHoleToOuterYEdge,yBarScrewHoleToFrontXEdge,sideWallConnLugDepression + 2*elevation])
                caseScrewShort();
        }
    }
}

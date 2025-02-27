include <../common.scad>

use <../enclosed-box/sideRail.scad>

/*
    Simple angle bracket mounting system. Mainly derived the enclosed box system. 
*/

/* [Visualization] */
// Show box mounting preview
visualize = false;

/* [Dimensions] */
// Thickness of the bracket material (mm)
thickness = 3; // [1:0.5:10]
// Width of the supported box (mm)
boxWidth = 160; // [80:10:300]
// Depth of the supported box (mm)
boxDepth = 120; // [80:10:300]
// Enable ventilation holes on sides
sideVent = false;
// Rack units (U) height
u = 3; // [1:1:8]

module angleBrackets (
        visualize = visualize,
        thickness = thickness,
        boxWidth = boxWidth,
        boxDepth = boxDepth,
        sideVent = sideVent,
        u = u
) {    
        sideSupportRailBase(top=false, defaultThickness=thickness, railSideThickness=thickness, supportedZ=10*u-2*thickness, supportedY=boxDepth, supportedX=boxWidth, sideVent=sideVent);

        rightRailTrans = visualize
                ? translate(v=[boxWidth,0,0]) * mirror(v=[1,0,0])
                : translate(v=[30,0,0]) * mirror(v=[1,0,0]);
                
        multmatrix(rightRailTrans)
        sideSupportRailBase(top=false, defaultThickness=thickness, railSideThickness=thickness, supportedZ=10*u-2*thickness, supportedY=boxDepth, supportedX=boxWidth, sideVent=sideVent);
}

angleBrackets();

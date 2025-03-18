include <../common.scad>
use <../plateBase.scad>


/*
A 4U (50mm tall) panel for nylon brush stripping to hide cable shame.

Brush Weather Stripping (0.35" Wide x 0.35" Thick): https://amzn.to/3CLpWMp
*/




plateU=4;
plateThickness=3;
brushstripWidth=8.89;
brushstripLength=8.89;
//How far from the edge of the plate the Brush Strip Hole will begin
brushstripOffset=15;
//How far the ledges that the brush strip affix too
brushstripHoleOverlap=5;


/* Reckless copying and pasting begins here */
screwToXEdge=4.5;
screwToYEdge=4.5;
uDiff = screwDiff;
filletR=2;
screwDx = rackMountScrewWidth;
screwDy = uDiff * plateU;
plateLength = screwDx + 2*screwToXEdge;
plateHeight = screwDy + 2*screwToYEdge;
railDefaultThickness = 1.5;
/* End of Reckless copying and pasting? */


brushstripLedgeX=plateLength - ((brushstripOffset-brushstripHoleOverlap)*2);
brushstripLedgeY=5;
brushstripLedgeZ=brushstripWidth*1.2;

brushstripHoleX=plateLength - (brushstripOffset*2);
brushstripHoleY=brushstripLength*2;
brushstripHoleZ=plateThickness*2;
midPlateY=(plateHeight)/2;

echo("Plate Height: ", plateHeight);
echo("Plate Length: ", plateLength);
echo("Vertical distance between 2 main rail holes: ", screwDiff);
echo("Horizontal distance between 2 opposing main rail holes: ", rackMountScrewWidth);
echo("Distance between main rail screw, and main rail inner edge:", railScrewHoleToInnerEdge);
echo("Max supported rack-mount width: ", maxUnitWidth);
echo("Max recommended rack-mount depth: ", maxUnitDepth);


difference(){
    plateBase(U=plateU, plateThickness=plateThickness, screwToXEdge=4.5, screwToYEdge=5.0, screwType="m4", filletR=2);
    translate([brushstripOffset,midPlateY-(brushstripHoleY/2),0]) brushstripHole();
}
translate([-screwToXEdge+(brushstripOffset-brushstripHoleOverlap),midPlateY-screwToYEdge+(brushstripHoleY/2),0]) cube([brushstripLedgeX, brushstripLedgeY, brushstripLedgeZ]);
translate([-screwToXEdge+(brushstripOffset-brushstripHoleOverlap),midPlateY-screwToYEdge-(brushstripHoleY/2)- brushstripLedgeY,0]) cube([brushstripLedgeX, brushstripLedgeY, brushstripLedgeZ]);

module brushstripHole(){
translate([-screwToXEdge,-screwToYEdge,-(plateThickness+1)]) cube([brushstripHoleX, brushstripHoleY, brushstripHoleZ]);    
}
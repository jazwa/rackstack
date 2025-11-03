include <../common.scad>
use <../plateBase.scad>

// Creates a ventilated blank plate with diagonal stripes
// U: Height in rack units (1, 2, 3, etc.)
// plateThickness: Thickness of the plate in mm (default: 3)
// screwType: Mounting screw type (default: "m4")
// filletR: Corner fillet radius in mm (default: 2)
// slotWidth: Width of ventilation slots in mm (default: 2)
// spacing: Distance between stripe centers in mm (default: 4)
// borderX: Margin from left/right edges in mm (default: 10)
// borderY: Margin from top/bottom edges in mm (default: 3)

module ventilatedPlate(U, plateThickness=3, screwType="m4", filletR=2, slotWidth=2, spacing=4, borderX=10, borderY=3) {
    difference() {
        plateBase(U=U, plateThickness=plateThickness, screwType=screwType, filletR=filletR);

        // Diagonal stripe ventilation
        screwDx = rackMountScrewWidth;
        screwDy = uDiff * U;
        screwToEdge = 4.5;

        plateLength = screwDx + 2*screwToEdge;
        plateHeight = screwDy + 2*screwToEdge;
        diagonal = sqrt(plateLength*plateLength + plateHeight*plateHeight);

        translate([-screwToEdge, -screwToEdge, 0]) {
            intersection() {
                // Clip stripes to inner area (with border)
                translate([borderX, borderY, -plateThickness])
                cube([plateLength - 2*borderX, plateHeight - 2*borderY, plateThickness*2], center=false);

                // Diagonal stripes (/)
                union() {
                    for (i = [-plateHeight:spacing:plateLength+plateHeight]) {
                        translate([i, 0, -plateThickness/2])
                        rotate([0, 0, 45])
                        cube([slotWidth, diagonal, plateThickness*3], center=true);
                    }
                }
            }
        }
    }
}

// Examples:
ventilatedPlate(U=1);
translate([0, 25, 0]) ventilatedPlate(U=2, spacing=10, slotWidth=2);
translate([0, 60, 0]) ventilatedPlate(U=3, spacing=30, borderX=20, slotWidth=8);

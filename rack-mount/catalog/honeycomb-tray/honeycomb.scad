
// ===== Combined Assembly (Fixed): Entry Brackets + Honeycomb Tray =====
// - Uses your exact bracket geometry from entry.scad
// - Places right bracket using visualize=true so spacing = boxWidth
// - Honeycomb subtraction fixed: keeps walls, removes hex cores
//
// Keep your project structure so `use <entry.scad>` resolves correctly.
use <entry.scad>;

// ---------------- User Parameters ----------------
boxWidth        = 145;
boxDepth        = 145;
base_thickness  = 3.0;   // tray plate thickness
wall_thickness  = 1.0;   // forwarded to entry.scad's thickness
u               = 4;
sideVent        = true;

// Honeycomb
hex_side   = 6.0;
cell_wall  = 1.5;
rim_width  = 3.0;

// Vertical and bonding tweaks
baseZ      = -1.0;     // Z of tray (align with rail bottoms, -1.0 puts it on print bed)
bondOverlapX = 3.0;   // extend tray under rails in X (each side)
bondOverlapY = 0.0;   // extend slightly front/back in Y if desired

// ---------------- Honeycomb Helpers ----------------
module __hex2d(side) {
    polygon(points=[ for (i=[0:5]) [ side*cos(60*i), side*sin(60*i) ] ]);
}

module __honeycomb_plate(width, depth, plate_h, side, wall, rim) {
    // Full plate, then subtract ONLY the inner hex cores inside the rim area.
    difference() {
        cube([width, depth, plate_h], center=false);

        // Subtract hex cores
        x_step = 1.5 * side;
        y_step = sqrt(3) * side;
        w = width  - 2*rim;
        d = depth  - 2*rim;

        translate([rim, rim, 0])
        union() {
            for (ix = [0 : ceil(w / x_step) + 1]) {
                x = side + ix * x_step;
                y_off = (ix % 2) * (y_step/2);
                for (iy = [0 : ceil(d / y_step) + 1]) {
                    y = y_off + iy * y_step;
                    if (x >= 0 && x <= w && y >= 0 && y <= d) {
                        // subtract inner hex only -> leaves walls
                        translate([x, y, 0])
                            linear_extrude(height=plate_h + 0.05)
                                __hex2d(max(0.01, side - wall));
                    }
                }
            }
        }
    }
}

// ---------------- Bridge to your entry.scad ----------------
module __entry_brackets(
    wall_t = wall_thickness,
    width  = boxWidth,
    depth  = boxDepth,
    unit   = u,
    vent   = sideVent
) {
    // visualize=true so right rail is placed at x=boxWidth
    angleBrackets(
        visualize = true,
        thickness = wall_t,
        boxWidth  = width,
        boxDepth  = depth,
        u         = unit,
        sideVent  = vent
    );
}

// ---------------- Final Assembly ----------------
module angleBrackets_with_honeycomb_tray(
    width        = boxWidth,
    depth        = boxDepth,
    base_h       = base_thickness,
    wall_t       = wall_thickness,
    unit         = u,
    vent         = sideVent,
    hex_side_in  = hex_side,
    cell_wall_in = cell_wall,
    rim_in       = rim_width,
    baseZ_in     = baseZ,
    bondOX       = bondOverlapX,
    bondOY       = bondOverlapY
) {
    union() {
        // 1) Brackets from your entry.scad
        __entry_brackets(wall_t=wall_t, width=width, depth=depth, unit=unit, vent=vent);

        // 2) Tray centered between x=[0,width] and y=[0,depth], with small overlap under rails
        translate([-bondOX, -bondOY, baseZ_in])
            __honeycomb_plate(width + 2*bondOX, depth + 2*bondOY, base_h, hex_side_in, cell_wall_in, rim_in);
    }
}

// Preview
angleBrackets_with_honeycomb_tray();

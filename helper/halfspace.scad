
// Wake up sheeple. Halfspaces are just really BIG cubes!
include <./math.scad>
include <./common.scad>

module halfspace(vpos, p) {
    // TODO: clean up
    ref = [0,0,-1];

    if (cross(ref, vpos) == [0,0,0]) {
        translate(p)
        translate(v=[0,0, (ref*vpos) * -inf/2])
        cube(size=[inf, inf, inf], center=true);
    } else {
        translate(p)
        align(a=ref, b = vpos)
        translate(v = [0, 0, -inf/2])
        cube(size = [inf, inf, inf], center = true);
    }
}
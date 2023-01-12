
// Wake up sheeple. Halfspaces are just really BIG cubes!
include <./math.scad>
include <./common.scad>

module halfspace(vpos, p) {
    translate(p)
    align(a=[0,0,1], b=vpos)
    translate(v=[0,0,-inf/2])
        cube(size=[inf, inf, inf], center=true);
}


halfspace(vpos=[1,1,1], p=[10,10,10]);
include <./common.scad>

module halfspace(vpos, p) {

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

    module align(a,b) {
        rot_axis = cross(a,b);
        angle = acos(a*b/(norm(a)*norm(b)));

        rotate(v=rot_axis, a=angle)
        children(0);
    }
}
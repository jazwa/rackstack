// Some misc math-y utils

$fn=64;
eps=0.001;
rh=1; // preview render helper :)
inf10 = 10;
inf50 = 50;
inf1000 = 1000;
inf = inf1000;

function unit(v) = v/norm(v);

function lerp(a, b, t) = (b * t + a * (1 - t));

/* Example usage:
for (i=mirror4XY(midpoint=[0,0,0], offsetX=90, offsetY=90))
   { translate(v=i) something(); }
*/
module mirror4XY(p, dx, dy) {

    px = p[0];
    py = p[1];

    translate(v=[px, py, 0])
    children(0);

    translate(v=[px+dx, py, 0])
    children(0);

    translate(v=[px, py+dy, 0])
    children(0);

    translate(v=[px+dx, py+dy, 0])
    children(0);
}

/* Generate a 4x4 matrix that causes a change of basis
such that the origin is at point p0, the x axis is aligned
from p0 to p1 and point p2 is in the first quadrant.
Copied and pasted from https://trmm.net/Basis/
*/
module alignTo(p0,p1,p2) {

    x = unit(p1-p0);
    yp = unit(p2-p0);
    z = unit(cross(x,yp));
    y = unit(cross(z,x));

    multmatrix([
            [x[0], y[0], z[0], p0[0]],
            [x[1], y[1], z[1], p0[1]],
            [x[2], y[2], z[2], p0[2]],
            [ 0,   0,    0,    1]
        ])
    children();
}

module halfspace(vpos, p) {

    ref = [0,0,-1];

    if (cross(ref, vpos) == [0,0,0]) {
        translate(p)
        translate(v=[0,0, (ref*vpos) * -inf/2])
        cube(size=[inf, inf, inf], center=true);
    } else {
        translate(p)
        alignPlanar(a=ref, b = vpos)
        translate(v = [0, 0, -inf/2])
        cube(size = [inf, inf, inf], center = true);
    }

}

module alignPlanar(a,b) {
    rot_axis = cross(a,b);
    angle = acos(a*b/(norm(a)*norm(b)));

    rotate(v=rot_axis, a=angle)
    children(0);
}
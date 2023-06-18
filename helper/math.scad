// TODO remove/rename this file
/* Example usage:
for (i=mirror4XY(midpoint=[0,0,0], offsetX=90, offsetY=90)) {
    translate(v=i)
        something();
}
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

// Generate a 4x4 matrix that causes a change of basis
// such that the origin is at point p0, the x axis is aligned
// from p0 to p1 and point p2 is in the first quadrant.
// Copied and pasted from https://trmm.net/Basis/
module align_to(p0,p1,p2) {

    x = unit(p1-p0);
    yp = unit(p2-p0);
    z = unit(cross(x,yp));
    y = unit(cross(z,x));

    echo(p0,p1,p2);
    echo(x,y,z);

    multmatrix([
            [x[0], y[0], z[0], p0[0]],
            [x[1], y[1], z[1], p0[1]],
            [x[2], y[2], z[2], p0[2]],
            [ 0,   0,    0,    1]
        ])
    children();
}

function unit(v) = v/norm(v);
function lerp(a, b, t) = (b * t + a * (1 - t));

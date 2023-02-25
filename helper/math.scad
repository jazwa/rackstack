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

module align(a,b) {

    rot_axis = cross(a,b);

    if (rot_axis == [0,0,0]) {
        error("Can't align - provided vectors are parallel");
    }

    angle = acos(a*b/(norm(a)*norm(b)));

    rotate(v=rot_axis, a=angle)
        children(0);
}
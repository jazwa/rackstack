// TODO remove/rename this file
/* Example usage:
for (i=mirror4XY(midpoint=[0,0,0], offsetX=90, offsetY=90)) {
    translate(v=i)
        something();
}
*/
function mirror4XY(midpoint, offsetX, offsetY)  =
    [[midpoint[0]+offsetX, midpoint[1]+offsetY, midpoint[2]],
        [midpoint[0]-offsetX, midpoint[1]+offsetY, midpoint[2]],
        [midpoint[0]-offsetX, midpoint[1]-offsetY, midpoint[2]],
        [midpoint[0]+offsetX, midpoint[1]-offsetY, midpoint[2]]];


module align(a,b) {

    echo("a", a);
    echo("b", b);
    rot_axis = cross(a,b);

    if (rot_axis == [0,0,0]) {
        error("Can't align - provided vectors are parallel");
    }

    //echo("rot_axis", rot_axis);

    angle = acos(a*b/(norm(a)*norm(b)));
    echo("angle", angle)

    rotate(v=rot_axis, a=angle)
        children(0);
}
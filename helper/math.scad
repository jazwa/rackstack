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
    rot_axis = cross(a,b);
    angle = acos(a*b/ (norm(a)*norm(b)));

    rotate(v=rot_axis, a=angle)
        children(0);
}

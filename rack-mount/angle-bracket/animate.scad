use <./entry.scad>

$vpt = [120,-30,63];
$vpr = [74,0,25];
$vpd = 550;
$vpf = 22.50;

animateAngleBrackets(at=$t);


module animateAngleBrackets(at=$t) {

    x = 150;
    y = 70;
    dx = abs(lerp(a=-20, b=20, t=at));    
    dy = abs(lerp(a=-50, b=50, t=at));

    u = abs(at - 0.5) > 0.25 ? 3 : 4;

    angleBrackets(visualize=true, boxWidth=x+dx, boxDepth=y+dy, u=u);

}



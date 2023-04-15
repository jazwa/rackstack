include <./stackConnector.scad>
include <../helper/halfspace.scad>
include <./sharedVariables.scad>

// Distance from midpoint of stack connectors to each other
stackConnectorDx = rackTotalWidth - 2*(connectorXEdgeToYBarXEdge + connectorRectWidth/2);
stackConnectorDy = rackTotalDepth - 2*(connectorYEdgeToYBarYEdge + connectorRectDepth/2);


stackConnectorFeet();

module stackConnectorFeet() {

  bandThickness = 2;
  height = 14;
  protrusionAngle = 30;


  // stack connectors along rack x axis
  translate(v=[-(stackConnectorDx+connectorRectWidth)/2,-connectorRectDepth/2,0])
  mirror(v=[0,0,1]) {
    translate(v = [stackConnectorDx, 0, 0])
    stackConnectorBottom();

    stackConnectorBottom();
  }
  band();


  module band() {

    intersection() {
      translate(v=[0,0,2])
      difference() {
        roundedCube(rackTotalWidth, inf50, height, 3, center = true);

        translate(v=[0,0,3])
        roundedCube(rackTotalWidth-6, inf50, height-6, 3, center = true);
      }

      halfspace(vpos=[0,1,0],p=[0,-5,2]);
      halfspace(vpos=[0,-1,0.75],p=[0,5,2]);

      halfspace(vpos=[0,-1,0],p=[0,14,2]);
    }

  }

  module roundedCube(x,y,z,r, center=false) {
    translate(v=[0,0,z/2])
    minkowski() {
      cube(size=[x-2*r,y,z-2*r], center=center);

      rotate(a=[90,0,0])
      cylinder(r=r, h=eps);
    }
  }
}

module stackConnectorHandle() {

}
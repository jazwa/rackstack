include <../helper/common.scad>
include <./sharedVariables.scad>
include <./connector/connectors.scad>

// Distance from midpoint of stack connectors to each other
stackConnectorDx = rackTotalWidth - 2*(connectorXEdgeToYBarXEdge + connectorRectWidth/2);
stackConnectorDy = rackTotalDepth - 2*(connectorYEdgeToYBarYEdge + connectorRectDepth/2);
stackConnectorDualSpacing = 0.5;

module rackJoiner() {
  translate(v=[0,0,stackConnectorDualSpacing/2])
  stackConnectorPlug();

  mirror(v=[0,0,1])
  translate(v=[0,0,stackConnectorDualSpacing/2])
  stackConnectorPlug();

  translate(v=[0,0,-stackConnectorDualSpacing/2])
  cube(size=[connectorRectWidth+connectorRectPlugSlack, connectorRectDepth+connectorRectPlugSlack, stackConnectorDualSpacing]);
}

module rackFeet() {

  bandThickness = 2;
  height = 18;
  protrusionAngle = 30;

  translate(v = [stackConnectorDx/2, 0, 2])
  mirror(v=[0,0,1]) {
    // stack connectors along rack x axis
    translate(v = [-(stackConnectorDx+connectorRectWidth)/2, -connectorRectDepth/2, 2-overhangSlack])
    mirror(v = [0, 0, 1]) {
      translate(v = [stackConnectorDx, 0, 0])
      stackConnectorBottom();

      stackConnectorBottom();
    }
    band();
  }

  module band() {

    intersection() {
      translate(v=[0,0,2])
      difference() {
        roundedCube(rackTotalWidth, inf50, height, 5, center = true);

        translate(v=[0,0,3])
        roundedCube(rackTotalWidth-6, inf50, height-6, 3, center = true);
      }

      halfspace(vpos=[0,1,-0.8],p=[0,-8,2]);
      halfspace(vpos=[0,-1,0.75],p=[0,6,2]);

      halfspace(vpos=[0,-1,0],p=[0,16,2]);
      halfspace(vpos=[0,1,0],p=[0,-5,2]);
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
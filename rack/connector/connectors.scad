// Connector Aggregator and utils

include <../../helper/common.scad>
include <../../config/common.scad>
include <./xBarYBarConnectors.scad>
include <./mainRailYBarConnectors.scad>
include <./sideModuleYBarConnectors.scad>
include <./stackYBarConnectors.scad>
include <./basePlateYBarConnectors.scad>
include <./transformations.scad>

// Default is to apply the positive first
module applyConnector(on, to, trans) {

  apply_pn() {
    multmatrix(trans)
    connectorPositive(on=on, to=to);

    multmatrix(trans)
    connectorNegative(on=on, to=to);

    children(0);
  }
}

module connectorDebug(on, to, trans) {

  color([0,1,0])
  multmatrix(trans)
  connectorPositive(on=on, to=to);

  color([1,0,0])
  multmatrix(trans)
  connectorNegative(on=on, to=to);
}

module applyConnectorDebug(on,to,trans) {

  echo("on: ", on, "-- to:", to);

  apply_p() {
    multmatrix(trans)
    connectorDebug(on=on,to=to,trans=trans);

    children(0);
  }
}

module connectorPositive(on, to) {

  if (on == "yBar" && to == "xBar") {
    onYBarToXBarPositive();
  } else if (on == "yBar" && to == "basePlate") {
    onYBarBasePlateConnectorPositive();
  } else if (on == "yBar" && to == "magnetModule") {
    onYBarMagnetModulePositive();
  } else if (on == "yBar" && to == "hingeModule") {
    onYBarHingeModulePositive();
  } else if (on == "basePlate" && to == "yBar") {
    onBasePlateToYBarConnectorPositive();
  } else if (on == "xBar" && to == "yBar") {
    onXBarToYBarPositive();
  } else if (on == "mainRail" && to == "yBar") {
    onMainRailYBarConnectorPositive();
  }
}

module connectorNegative(on, to) {

  if (on == "yBar" && to == "xBar") {
    onYBarToXBarNegative();
  } else if (on == "xBar" && to == "yBar") {
    onXBarToYBarNegative();
  } else if (on == "yBar" && to == "sideModule") {
    onYBarSideModuleNegative();
  } else if (on == "yBar" && to == "hingeModule") {
    onYBarHingeModuleNegative();
  } else if (on == "yBar" && to == "mainRail") {
    onYBarToMainRailNegative();
  } else if (on == "yBar" && to == "stackConnector") {
    onYBarStackConnectorNegative();
  } else if (on == "yBar" && to == "basePlate") {
    onYBarBasePlateConnectorNegative();
  } else if (on == "mainRail" && to == "yBar") {
    onMainRailYBarConnectorNegative();
  }
}

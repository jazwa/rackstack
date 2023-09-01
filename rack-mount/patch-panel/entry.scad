use <./patchPanel.scad>

/*
  Parametric patch panel for rj45 keystones

  Please also make sure that the correct rack frame preset is set in rackFrame.scad.

  TODO add support for 2d arrays
*/

module patchPanelSystem (

// begin config ////////////////////////////////////////////////////////////////////////////////////////////////////////

numSlots = 8,
plateThickness = 3,
keystoneSpacing = 19

// end config //////////////////////////////////////////////////////////////////////////////////////////////////////////

) {
  mirror(v = [0, 0, 1])
    patchPanel(slots = numSlots);
}

patchPanelSystem();
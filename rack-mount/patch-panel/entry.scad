use <./patchPanel.scad>

/*
  Parametric patch panel for rj45 keystones

  Please also make sure that the correct rack frame preset is set in rackFrame.scad.

  TODO add support for 2d arrays
*/

module patchPanelSystem (

// begin config ////////////////////////////////////////////////////////////////////////////////////////////////////////

// 1 for the original keystone mount design, 2 for a visually cleaner keystone mount
// but where the keystone is a bit harder to remove
// 3 for a cube with the height of plateThickness,
// 4 and 5 for cubes with the same height as keystone1 and 2
slots = [2, 2, 2, 2, 2, 2, 2, 5, 2],
plateThickness = 3,
keystoneSpacing = 19,
center = false

// end config //////////////////////////////////////////////////////////////////////////////////////////////////////////

) {
  mirror(v = [0, 0, 1])
    patchPanel(slots = slots, plateThickness = 3, keystoneSpacing = 19, center=center);
}

patchPanelSystem();

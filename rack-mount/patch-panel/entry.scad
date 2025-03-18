use <./patchPanel.scad>

/*
  Parametric patch panel for rj45 keystones

  Please also make sure that the correct rack frame preset is set in rackFrame.scad.

  TODO add support for 2d arrays
*/

/* [Patch Panel Settings] */
// Number of keystone slots
numSlots = 8; // [1:1:24]
// Thickness of the panel plate
plateThickness = 3; // [1:0.5:5]
// Spacing between keystones
keystoneSpacing = 19; // [15:0.5:25]
// Center the panel
center = false; // [true,false]

module patchPanelSystem (
    numSlots = numSlots,
    plateThickness = plateThickness,
    keystoneSpacing = keystoneSpacing,
    center = center
) {
  mirror(v = [0, 0, 1])
    patchPanel(slots = numSlots, center=center);
}

patchPanelSystem();

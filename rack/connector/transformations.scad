// Spatial transformations between various parts' local spaces
include <./connectors.scad>


function transform(from, to) =
  (from == "yBar" && to == "xBar")
  ? identity
  : (from == "xBar" && to == "yBar")
  ? identity
  : identity;

include <./sideWallBase.scad>

sideWallLeft();

module sideWallLeft() {

  numVentsCustom = sideWallVentilation? ceil((sideWallZ - 2*sideWallDefaultVentilationToYEdge)/10): 0;

  applySideWallDefaultVentilation(numVents=numVentsCustom)
  sideWallBase();
}

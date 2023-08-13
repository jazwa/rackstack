include <./sideWallBase.scad>

*sideWallLeft();

module sideWallLeft() {

  numVentsCustom = ceil((sideWallZ - 2*sideWallDefaultVentilationToYEdge)/10);

  applySideWallBracing(numRibs=2)
  applySideWallDefaultVentilation(numVents=numVentsCustom)
  sideWallBase();
}

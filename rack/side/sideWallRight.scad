include <./sideWallBase.scad>

*sideWallRight();

module sideWallRight() {

  numVentsCustom = ceil((sideWallZ - 2*sideWallDefaultVentilationToYEdge)/10);

  mirror(v=[1,0,0])
  applySideWallBracing(numRibs=2)
  applySideWallDefaultVentilation(numVents=numVentsCustom)
  sideWallBase();
}


include <./sideWallBase.scad>

sideWallRight();

module sideWallRight() {

  numVentsCustom = sideWallVentilation? ceil((sideWallZ - 2*sideWallDefaultVentilationToYEdge)/10): 0;

  mirror(v=[1,0,0])
  applySideWallDefaultVentilation(numVents=numVentsCustom)
  sideWallBase();
}


include <../helper/common.scad>
include <../helper/screws.scad>
include <./config.scad>

module yBarBasePlateMount_P(mountX=12, mountY=12, mountZ=12) {
  cube(size=[mountX, mountY, mountZ]);
}

module yBarBasePlateMount_N(innerEdgeToScrew=6, baseConnectorRecession = 2) {

  translate(v=[innerEdgeToScrew,innerEdgeToScrew, m3HeatSetInsertSlotHeightSlacked + baseConnectorRecession])
  mirror(v=[0,0,1])
  heatSetInsertSlot_N(rackFrameScrewType, topExtension=inf10);

  translate(v=[2,2,0])
  cube(size=[inf50,8,baseConnectorRecession]);

  translate(v=[innerEdgeToScrew,innerEdgeToScrew, baseConnectorRecession+m3CounterSunkHeadLength])
  mirror(v=[0,0,1])
  *counterSunkHead_N(rackFrameScrewType, screwExtension=0, headExtension=eps);
}

*difference() {
  yBarBasePlateMount_P();
  yBarBasePlateMount_N(innerEdgeToScrew=6,wallThickness=3);
}

*yBarBasePlateMount_N(innerEdgeToScrew=6);

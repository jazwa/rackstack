include <./common.scad>
include <./rack/screws.scad>

vU = 2;
uHeight = 10;

plateScrewDiffV = uHeight*vU;
plateScrewDiffH = 180;

plateScrewToHEdge = 4.5;
plateScrewToVEdge = 5.5;

frontPlateThickness = 3;

frontPlateV = plateScrewDiffV + 2*plateScrewToHEdge;
frontPlateH = plateScrewDiffH + 2*plateScrewToVEdge;


plateScrewToBoxMin = 6;

module _frontPlateBody() {
  translate(v=[-plateScrewToVEdge,0,-plateScrewToHEdge])
    cube(size=[frontPlateH,frontPlateThickness,frontPlateV]);
}

module _plateHole() {
  rotate(a=[90,0,0])
    cylinder(r=m4RadiusSlacked, h=inf, center=true);
}


module frontPlate() {

  difference() {
    _frontPlateBody();

    union() {
      // TODO: introduce helper modules for this pattern
      _plateHole();

      translate(v=[plateScrewDiffH,0,0])
        _plateHole();

      translate(v=[0,0,plateScrewDiffV])
        _plateHole();

      translate(v=[plateScrewDiffH,0,plateScrewDiffV])
        _plateHole();
    }
  }
}

// keystone stuff

// a lot of these variables are useless, after a couple of design iterations

keystoneMainBodyWidth = 15.0;
keystoneMainBodyHeight = 16.90;
keystoneMainBodyDepth = 32.90;


heightWithHookBody = 20.2;
heightWithHookCatch = 21.30;

widthWithSideLugs = 15.96;

sideLugWidth = (widthWithSideLugs - keystoneMainBodyWidth) / 2.0;


heightWithBottomLug = 17.5;

frontToHookCatch = 8.35; // not sure about this
frontToBottomLugBack = 8.23;
frontToSideLugFront = 10.63;


module keystoneSlot_N() {
  // main keystone body (no hooks or lugs)
  cube(size=[keystoneMainBodyWidth, keystoneMainBodyDepth, keystoneMainBodyHeight]);


  // slot for top hook
  translate(v=[0,frontToHookCatch,0])
  cube(size=[keystoneMainBodyWidth, keystoneMainBodyDepth -frontToHookCatch, heightWithHookBody]);
  cube(size=[keystoneMainBodyWidth, frontToHookCatch, heightWithHookCatch]);


  // slots for side lugs
  translate(v=[-sideLugWidth, frontToSideLugFront,0])
  cube(size=[widthWithSideLugs, keystoneMainBodyDepth-frontToSideLugFront, keystoneMainBodyHeight]);

  // slots for bottom lugs
  translate(v=[0,0,-(heightWithBottomLug-keystoneMainBodyHeight)])
  cube(size=[keystoneMainBodyWidth, frontToBottomLugBack, keystoneMainBodyHeight]);
  
}


module keystoneJack_N() {
  translate(v=[0,-4,0.5])
  intersection() {
    translate(v=[-2.5,4,-4])
      cube(size=[20,6,28]);
    keystoneSlot_N();
  }
}

//keystoneJack_N();

module patchPanel_P() {
  
  frontPlate();
  for (i = [0:7]) {
    translate(v=[(i*20+12.5)-2.5,0,-4.5])
      cube(size=[20,6,29]);
  } 

}


module patchPanel() {
  difference() {
    patchPanel_P();

    for (i = [0:7]) {
      translate(v=[i*18 + 12.5,0,-2])
      keystoneJack_N();
  } 
  }
}

patchPanel();

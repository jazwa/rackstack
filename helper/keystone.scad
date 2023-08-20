
include <../config/common.scad>

// rj45 slot-to-slot keystone jack model and negative
keystoneMainBodyWidth = 15.0;
keystoneMainBodyHeight = 16.90;
keystoneMainBodyDepth = 32.90;

heightWithHookBody = 20.2;
heightWithHookCatch = 21.30;
widthWithSideLugs = 15.96;
sideLugWidth = (widthWithSideLugs - keystoneMainBodyWidth) / 2.0;

heightWithBottomLug = 17.5;

frontToHookCatch = 8.35;
frontToBottomLugBack = 8.23;
frontToSideLugFront = 10.63;

module rj45Keystone() {
    // main keystone body (no hooks or lugs)
    cube(size=[keystoneMainBodyWidth + xySlack, keystoneMainBodyDepth + xySlack, keystoneMainBodyHeight]);

    // slot for top hook
    translate(v=[0,frontToHookCatch,0])
    cube(size=[keystoneMainBodyWidth + xySlack, keystoneMainBodyDepth-frontToHookCatch + xySlack, heightWithHookBody]);

    cube(size=[keystoneMainBodyWidth + xySlack, frontToHookCatch + xySlack, heightWithHookCatch]);

    // slots for side lugs
    translate(v=[-sideLugWidth, frontToSideLugFront,0])
    cube(size=[widthWithSideLugs + xySlack, keystoneMainBodyDepth-frontToSideLugFront + xySlack, keystoneMainBodyHeight]);

    // slots for bottom lugs
    translate(v=[0,0,-(heightWithBottomLug-keystoneMainBodyHeight)])
    cube(size=[keystoneMainBodyWidth + xySlack, frontToBottomLugBack + xySlack, keystoneMainBodyHeight]);

}

module rj45KeystoneJack_N() {
    translate(v=[0,-4,0.5]) // why?
    intersection() {
        translate(v=[-2.5,4,-4])
        cube(size=[20,6,28]);
        rj45Keystone();
    }
}

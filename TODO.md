# case-project TODO list

### Actual TODO

- Finish refactoring files to use the application style, like in `yBar.scad`.
- Figure out why sidewall build is so slow.
- Clean up `sharedVariables.scad`.
- Parallel builds with cli tool. 
- Beef up rack-mount designs.
- Make handles.

### Ideas
- Start using matrices for transformations. Enforce strict local/global hierarchy of matrix transformations. (Kinda done)
- GitHub CI for OpenSCAD stl building
- Instead of using names like 'mainRailSlotToInnerYZFace', experiment with a central distance/dimension directory. Like:
```openscad
// Define identifiers:
mainRailSlot = "mainRailSlotIdentifier";
yBarInnerYZ = "yBarInnerYZFaceIdentifier";

// Define distance
setDx(mainRailSlot, yBarInnerYZ, 3);

// Define dimensions
setX(mainRailSlot, 10);
setX(yBarInnerYZ, 0);

// Then, you can get distances like:
dx(mainRailSlot, yBarInnerYZ); // == 3
dx(yBarInnerYZ, mainRailSlot); // == 3

dx(mainRailSlot, blah); //throw error

// And you could possible chain distances like:

dx(yBarInnerYZ, mainRailSlot, sideConnectorSlot); 
// which would eval to:
// dx(yBarInnerYZ, mainRailSlot) + x(mainRailSlot) + dx(mainRailSlot, sideConnectorSlot); 
// OR 
dx(yBarInnerYZ, mainRailSlot, sideConnectorSlot, includeFirst=true, includeLast=true);
// which would eval to:
// x(yBarInnerYZ) + dx(yBarInnerYZ, mainRailSlot, sideConnectorSlot) + x(sideConnectorSlot);
```
Hmm after looking into it a bit it seems that OpenScad's non-reassign rule is going to get in the way. Might still be
worthwhile implement variable subsystem?


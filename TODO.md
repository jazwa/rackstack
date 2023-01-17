# case-project TODO list

### Actual TODO

- Finish refactoring files to use the application style, like in `yBar.scad` 
- Implement better build script using python

### Ideas

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



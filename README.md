# rackstack

![display](media/renders/rackDisplayRounded.png)

### A parametric 3d-printable mini rack system
- ***Mount Anything:*** Perfect for organizing SBCs, mini PCs, small switches, power hubs, etc.
- ***Fully customizable:*** Fully written in OpenSCAD. Everything, from the dimensions of the rack, to the roundness of the corners, can be modified with a simple code change.
- ***Printable from home:*** Designed to be printed with conventional FDM printers. Requires minimal supports when printing, and final assembly needs only a few easy-to-source parts. 
- ***No cage nuts!*** Sliding hex nut design for the front rails allows one to easily mount items without dealing with cage nuts.
- ***Stackable:*** Individual racks can be easily stacked and fastened together. Mix and match different color and design combinations!

### Renders
See the [renders for difference parametric profiles here](media/renders)

## Assembly

Pre-generated STLs for roughly 200mm^3, and 100mm^3 rack frames can be found in [stl/rack](stl/rack).
These STLs are generated from the files in [rack/print](rack/print), and [rack-mount/print](rack-mount/print) - further information about printing these parts 
(supports, orientation) can be found in their respective `.scad` files.

### Assembly Instructions

### BOM

TODO

- A bunch of m3 screws for constructing the actual rack.
- A bunch of m4 screws for the main rails
- Some heatset inserts
- A bunch of m3 hex nuts
- m3 allen key (preferably with a rounded end)
- m4 allen key
- 2 dowel pins
- 8 magnets

| Item                        | Quantity     | Comment                                               |
|-----------------------------|--------------|-------------------------------------------------------|
| M3x5 FHCS                   | left-aligned |                                                       |
| M3x8 FHCS                   | centered     |                                                       |
| M3 hex nut                  | 4            |                                                       |
| M3 Brass Heatset Insert ()  | 32           |                                                       |
| 3x10mm steel dowel pin      | 4            | Not strict: dimensions can be changed. Please see ... |
| 6x2mm neodymium disc magnet | 8            | 6mm diameter, 2mm height                              |
|                             |              |                                                       |


## Configuring + Generating STLs

TODO

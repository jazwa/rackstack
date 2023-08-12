# rackstack

![display](media/renders/rackDisplayRounded.png)

### A parametric 3d-printable mini rack system
- ***Mount Anything:*** Perfect for organizing SBCs, mini PCs, small switches, power hubs, etc.
- ***Fully customizable:*** Fully written in OpenSCAD. Everything, from the dimensions of the rack, to the roundness of the corners, can be modified with a simple code change.
- ***Printable from home:*** Designed to be printed with conventional FDM printers. Requires minimal supports when printing, and final assembly needs only a few easy-to-source parts. 
- ***No cage nuts!*** Sliding hex nut design for the front rails allows one to easily mount items, without dealing with cage nuts.
- ***Stackable:*** Individual racks can be easily stacked and fastened together. Mix and match different color and design combinations!

## Assembly

Pre-generated STLs for roughly 200mm^3 (mini), 180mm^3 (micro), and 100mm^3 (nano) rack frames can be found in [stl](stl).
These STLs are generated from the files in [rack/print](rack/print), and [rack-mount/print](rack-mount/print) - further information about printing these parts 
(supports, orientation) can be found in these files.

### Assembly Instructions
Please see [the assembly README here](./assembly-guide)

### Required Tools:
- 3d FDM Printer - build size requirements depend on configured rack profile
- M3 Allen Key (for constructing the rack)
- M4 Allen Key (for mounting rack-mount items)

### BOM - Single Rack:

| Item                                                          | Name                      | Quantity | Comment                                                                                                                          |
|---------------------------------------------------------------|---------------------------|----------|----------------------------------------------------------------------------------------------------------------------------------|
| <img src="media/bom/fhcs_short.gif"  height="60" width="72">  | M3x8 FHCS                 | 8        | Extras are useful and inexpensive. If you plan on eventually stacking multiple racks together, don't hesitate to get a lot more. |
| <img src="media/bom/fhcs_medium.gif"  height="60" width="72"> | M3x12 FHCS                | 12       | ☝️                                                                                                                               |
| <img src="media/bom/fhcs_long.gif"  height="60" width="72">   | M3x16 FHCS                | 16       | ☝️                                                                                                                               |
| <img src="media/bom/hex_nut.gif"  height="60" width="72">     | M3 hex nut                | 36       | ☝️                                                                                                                               |
| <img src="media/bom/dowel.gif"  height="60" width="72">       | 3x10 steel dowel pin      | 4        | 3mm diameter, 10mm height                                                                                                        |
| <img src="media/bom/magnet.gif"  height="60" width="72">      | 6x2 neodymium disc magnet | 8        | 6mm diameter, 2mm height                                                                                                         |
| <img src="media/bom/glue.gif"  height="60" width="72">        | super glue                | \>= 2ml  | Used to glue magnets to plastic                                                                                                  |


### Printing - Single Rack:
| Part                                                         | Quantity |
|--------------------------------------------------------------|----------|
| [Y-Bar](./rack/print/yBar_P.scad)                            | 4        |
| [X-Bar](./rack/print/xBar_P.scad)                            | 4        |
| [Main Rail](./rack/print/mainRail_P.scad)                    | 4        |
| [Left Magnet Module](./rack/print/magnetModuleLeft_P.scad)   | 2        |
| [Right Magnet Module](./rack/print/magnetModuleRight_P.scad) | 2        |
| [Hinge Module](./rack/print/hingeModule.scad)                | 4        |
| [Left Side Wall](./rack/print/sideWallLeft_P.scad)           | 1        |
| [Right Side Wall](./rack/print/sideWallRight_P.scad)         | 1        |
| [XY-Plate](./rack/print/xyPlate_P.scad)                      | 2        |
| [Feet](./rack/print/feet_P.scad) (optional)                  | 2        |


#### Notes: 
- Before printing the actual parts. It's recommended to print this evaluation part: [eval_P](./rack/print/eval_P.scad) to test tolerances. If you find the fits too tight/loose, you can adjust them [here](./config/slack.scad).
- Please also adjust [this file](./config/slicer.scad) to match your slicer settings.
- Omitted actual plastic for printing. Any conventional 3d printing plastic should do (PLA, PETG, ABS),
but beware of PLA's thermal limits. Higher infill is recommended for all parts.
- For joining two racks, you will need to print 4 [stackConnectorDuals](./rack/print/stackConnectorDual_P.scad), as well as 8 M3 hex nuts, and 8 M3x12 FHCS.
- Main front rails use M4 hex nuts and screws.
- Side rails are mounted using M3 hex nuts and screws.


## Configuring + Generating STLs
A python script:  [rbuild.py](./rbuild.py) is provided to generate different project stls.

Requirements:
  - `openscad` cli (Currently only supported on Linux/Mac). Please configure the path to the OpenSCAD binary in [rbuild.py](./rbuild.py) 
  - `python3`

### Examples:
Generate all project files for the `micro` profile:

`python3 rbuild.py -b all -c micro`

This will build all the parts defined in [rack/print](./rack/print), and put the STLs in [stl/micro](./stl/micro). 

For generating a specific part: 

`python3 rbuild.py -b yBar -c micro -t custom`

`rbuild.py` also support an optional `--nightly` flag, which means the build script will use the `openscad-nightly` command, instead of `openscad`.
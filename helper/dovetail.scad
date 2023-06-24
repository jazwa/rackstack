include <./math.scad>

// centered on z axis
module dovetail(
  topWidth,
  bottomWidth,
  height,
  length,
  headExtension=0,
  baseExtension=0,
  frontFaceLength = 0,
  frontFaceScale = 0,
  backFaceLength = 0,
  backFaceScale = 0,
) {

  translate(v=[0,0,frontFaceLength])
  linear_extrude(length-(frontFaceLength+backFaceLength))
  dovetailFace(topWidth,bottomWidth,height,headExtension,baseExtension);

  translate(v=[0,0,frontFaceLength])
  mirror(v=[0,0,1])
  linear_extrude(frontFaceLength, scale=[frontFaceScale, frontFaceScale])
  dovetailFace(topWidth,bottomWidth,height,headExtension,baseExtension);

  translate(v=[0,0,length-backFaceLength])
  linear_extrude(backFaceLength, scale=[backFaceScale,1])
  dovetailFace(topWidth,bottomWidth,height,headExtension,baseExtension);



  module dovetailFace(topWidth, bottomWidth, height, headExtension, baseExtension) {

    union() {
      // base
      polygon(points =
        [[-bottomWidth/2, 0],
          [-topWidth/2, height],
          [topWidth/2, height],
          [bottomWidth/2, 0]]
      );

      polygon(points =
        [[-bottomWidth/2, -baseExtension],
          [-bottomWidth/2,0 ],
          [bottomWidth/2, 0],
          [bottomWidth/2, -baseExtension]]
      );

      translate(v=[0,height])
      polygon(points =
        [[-topWidth/2, headExtension],
          [-topWidth/2,0 ],
          [topWidth/2, 0],
          [topWidth/2, headExtension]]
      );
    }
  }


}
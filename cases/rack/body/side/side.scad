sideHeight = 210;
sideLength = 200;

holeOffset = 10;


// TODO make helper function for this
screwDiffs = [
        [sideLength-holeOffset, sideHeight-holeOffset,0],
        [holeOffset, holeOffset,0],
        [sideLength-holeOffset, holeOffset],
        [holeOffset, sideHeight-holeOffset],

        [sideLength-2*holeOffset, sideHeight-holeOffset,0],
        [2*holeOffset, holeOffset,0],
        [sideLength-2*holeOffset, holeOffset],
        [2*holeOffset, sideHeight-holeOffset]
];


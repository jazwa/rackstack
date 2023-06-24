
length = 100;
resolution = 128;
amplitude = 4.0;
period = PI;
shift = 0.0;

function radToDeg(r) = r * (180 / PI);
function sinR(r) = sin(radToDeg(r));


//sigmoid = function(x) exp(x) / (exp(x) + 1);
//dsigmoid = function(x) sigmoid(x) * (1-sigmoid(x));
//amplitudeFunction = function(x)  5*dsigmoid(x - 3) + 1;
amplitudeFunction = function(x) 1;

module sineWave(length, resolution, amplitudeFunction, period, shift) {
    dx = length / resolution;
    p = period / (2*PI);

    for (i = [1:resolution]) {
        idx_prev = (i - 1) * dx;
        idx_curr = i * dx;
        hull() {
            translate(v = [idx_prev, amplitudeFunction(idx_prev) * sinR(p * idx_prev + shift), 0])
                cube(size = [0.1, 2, 2]);

            translate(v = [idx_curr, amplitudeFunction(idx_curr) * sinR(p * idx_curr + shift), 0])
                cube(size = [0.1, 2, 2]);

            translate(v = [idx_curr, -10, 0])
                cube(size=[0.1,2,2]);
            translate(v = [idx_prev, -10, 0])
                cube(size=[0.1,2,2]);
        }
    }
}

module sineWaveHull(length, resolution, amplitudeFunction, period, shift, hullDiff) {
    dx = length / resolution;
    p = period / (2*PI);

    for (i = [1:resolution]) {
        idx_prev = (i - 1) * dx;
        idx_curr = i * dx;
        hull() {
            translate(v = [idx_prev, amplitudeFunction(idx_prev) * sinR(p * idx_prev + shift), 0])
                cube(size = [0.1, 2, 2]);

            translate(v = [idx_curr, amplitudeFunction(idx_curr) * sinR(p * idx_curr + shift), 0])
                cube(size = [0.1, 2, 2]);

            translate(v = [idx_curr, -hullDiff, 0])
                cube(size=[0.1,2,2]);
            translate(v = [idx_prev, -hullDiff, 0])
                cube(size=[0.1,2,2]);
        }
    }
}

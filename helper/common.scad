
/* Some commonly used variables plus functions
*/

$fn=64;
// TODO move these to math
eps=0.00000001;

inf10 = 10;
inf50 = 50;
inf1000 = 1000;
inf = inf1000;


module apply_p() {
  union() {
    children(0);
    children(1);
  }
}

module apply_n() {
  difference() {
    children(1);
    children(0);
  }
}

module apply_pn() {
  difference() {
    union() {
      children(0);
      children(2);
    }
    children(1);
  }
}

module apply_np() {
  difference() {
    union() {
      children(1);
      children(2);
    }
    children(0);
  }
}
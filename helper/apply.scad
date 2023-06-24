// Modules for apply pattern

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
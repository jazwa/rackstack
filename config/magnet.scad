include <./print.scad>

// Dimensions for small cylindrical neodymium magnets that I bought off Amazon
magnetR = 3;
magnetH = 1.7;

magnetRSlack = 0.1;
magnetHSlack = 0.05;

magnetRSlacked = magnetR + magnetRSlack;
magnetHSlacked = magnetH + magnetHSlack;
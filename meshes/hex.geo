/************************************************************************
 * hex.geo
 *
 * Generates a hexagonal column with face radius 1 and height h
 * e governs the mesh element size 
 * Defining aspect ratio as the ratio of the width to the height, then
 * h = 2*(aspect ratio)
 * S Groth 06/06/14
 * 
 ***********************************************************************/
e = 0.0628;   // mesh element size
h = 2.857;     // height (= 2 * aspect ratio)
s = -1;     // shift in z-direction
a = 1;

Point(1) = {a, 0, 0+s, e};
Point(2) = {a/2, 0.8660253999999999*a, 0+s, e};
Point(3) = {-a/2, 0.8660253999999999*a, 0+s, e};
Point(4) = {-a, 0, 0+s, e};
Point(5) = {-a/2, -0.8660253999999999*a, 0+s, e};
Point(6) = {a/2, -0.8660253999999999*a, 0+s, e};
Point(7) = {a, 0, h+s, e};
Point(8) = {a/2, 0.8660253999999999*a, h+s, e};
Point(9) = {-a/2, 0.8660253999999999*a, h+s, e};
Point(10) = {-a, 0, h+s, e};
Point(11) = {-a/2, -0.8660253999999999*a, h+s, e};
Point(12) = {a/2, -0.8660253999999999*a, h+s, e};

Line(1) = {1,2};
Line(2) = {2,3};
Line(3) = {3,4};
Line(4) = {4,5};
Line(5) = {5,6};
Line(6) = {6,1};
Line(7) = {1,7};
Line(8) = {2,8};
Line(9) = {3,9};
Line(10) = {4,10};
Line(11) = {5,11};
Line(12) = {6,12};
Line(13) = {7,8};
Line(14) = {8,9};
Line(15) = {9,10};
Line(16) = {10,11};
Line(17) = {11,12};
Line(18) = {12,7};

Line Loop(1) = {-1, -6, -5, -4, -3, -2};
Line Loop(2) = {1,8,-13,-7};
Line Loop(3) = {2,9,-14,-8};
Line Loop(4) = {3,10,-15,-9};
Line Loop(5) = {4, 11, -16, -10};
Line Loop(6) = {5, 12, -17, -11};
Line Loop(7) = {6, 7, -18, -12};
Line Loop(8) = {13, 14, 15, 16, 17, 18};

Plane Surface(1) = {1};
Plane Surface(2) = {2};
Plane Surface(3) = {3};
Plane Surface(4) = {4};
Plane Surface(5) = {5};
Plane Surface(6) = {6};
Plane Surface(7) = {7};
Plane Surface(8) = {8};

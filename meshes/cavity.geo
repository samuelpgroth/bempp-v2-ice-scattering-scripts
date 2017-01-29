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
h = 2.857;     // height (= 2 * aspect ratio) Yang et. al choose a=0.35L
s = -1;     // shift in z-direction
d = 0.25*h;   // cavity (dent) depth

Point(1) = {0, 0, 0+s+d, e};

Point(2) = {1, 0, 0+s, e};
Point(3) = {0.5, 0.8660253999999999, 0+s, e};
Point(4) = {-0.5, 0.8660253999999999, 0+s, e};
Point(5) = {-1, 0, 0+s, e};
Point(6) = {-0.5, -0.8660253999999999, 0+s, e};
Point(7) = {0.5, -0.8660253999999999, 0+s, e};

Point(8) = {1, 0, h+s, e};
Point(9) = {0.5, 0.8660253999999999, h+s, e};
Point(10) = {-0.5, 0.8660253999999999, h+s, e};
Point(11) = {-1, 0, h+s, e};
Point(12) = {-0.5, -0.8660253999999999, h+s, e};
Point(13) = {0.5, -0.8660253999999999, h+s, e};

Point(14) = {0, 0, h+s-d, e};

Line(1) = {1,2};
Line(2) = {1,3};
Line(3) = {1,4};
Line(4) = {1,5};
Line(5) = {1,6};
Line(6) = {1,7};
Line(7) = {2,3};
Line(8) = {3,4};
Line(9) = {4,5};
Line(10) = {5,6};
Line(11) = {6,7};
Line(12) = {7,2};
//Sides
Line(13) = {2,8};
Line(14) = {3,9};
Line(15) = {4,10};
Line(16) = {5,11};
Line(17) = {6,12};
Line(18) = {7,13};
//Top
Line(19) = {8,9};
Line(20) = {9,10};
Line(21) = {10,11};
Line(22) = {11,12};
Line(23) = {12,13};
Line(24) = {13,8};
Line(25) = {8,14};
Line(26) = {9,14};
Line(27) = {10,14};
Line(28) = {11,14};
Line(29) = {12,14};
Line(30) = {13,14};
/***************************** Surfaces **********************/
// Bottom
Line Loop(1) = {1,-12,-6};
Line Loop(2) = {2,-7,-1};
Line Loop(3) = {3,-8,-2};
Line Loop(4) = {4,-9,-3};
Line Loop(5) = {5,-10,-4};
Line Loop(6) = {6,-11,-5};

//Line Loop(1) = {1,7,-2};
//Line Loop(2) = {2,8,-3};
//Line Loop(3) = {3,9,-4};
//Line Loop(4) = {4,10,-5};
//Line Loop(5) = {5,11,-6};
//Line Loop(6) = {6,12,-1};
// Sides
Line Loop(7) = {7,14,-19,-13};
Line Loop(8) = {8,15,-20,-14};
Line Loop(9) = {9,16,-21,-15};
Line Loop(10) = {10,17,-22,-16};
Line Loop(11) = {11,18,-23,-17};
Line Loop(12) = {12,13,-24,-18};
// Top
Line Loop(13) = {19,26,-25};
Line Loop(14) = {20,27,-26};
Line Loop(15) = {21,28,-27};
Line Loop(16) = {22,29,-28};
Line Loop(17) = {23,30,-29};
Line Loop(18) = {24,25,-30};

Plane Surface(1) = {1};
Plane Surface(2) = {2};
Plane Surface(3) = {3};
Plane Surface(4) = {4};
Plane Surface(5) = {5};
Plane Surface(6) = {6};
Plane Surface(7) = {7};
Plane Surface(8) = {8};
Plane Surface(9) = {9};
Plane Surface(10) = {10};
Plane Surface(11) = {11};
Plane Surface(12) = {12};
Plane Surface(13) = {13};
Plane Surface(14) = {14};
Plane Surface(15) = {15};
Plane Surface(16) = {16};
Plane Surface(17) = {17};
Plane Surface(18) = {18};

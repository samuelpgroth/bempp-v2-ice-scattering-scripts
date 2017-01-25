/************************************************************************
 * 3branchesCube.geo
 *
 * Generates 3 branches of a bullet rosette with face radius 1 and height h.
 * e governs the mesh element size. 
 * p governs the distance from hex column to branch point.
 * This branch has a cube at the end of it. This is first branch in a 
 * LIPSCHITZ bullet rosette.
 * Defining aspect ratio as the ratio of the width to the height, then
 * h = 2*(aspect ratio).
 * S Groth 04/01/15
 * 
 ***********************************************************************/
e = 0.0209;   // mesh element size
h = 0.7556;     // height (= 2 * aspect ratio)
p = 0.2444;     // specifies distance from hex column to branch point
cr = 0.01;  // "radius" (i.e half width) of cube
a = 0.15;

/********************** 1st branch (points) *****************/
Point(1) = {a, 0, 0, e};
Point(2) = {a/2, 0.8660253999999999*a, 0, e};
Point(3) = {-a/2, 0.8660253999999999*a, 0, e};
Point(4) = {-a, 0, 0, e};
Point(5) = {-a/2, -0.8660253999999999*a, 0, e};
Point(6) = {a/2, -0.8660253999999999*a, 0, e};
Point(7) = {a, 0, h, e};
Point(8) = {a/2, 0.8660253999999999*a, h, e};
Point(9) = {-a/2, 0.8660253999999999*a, h, e};
Point(10) = {-a, 0, h, e};
Point(11) = {-a/2, -0.8660253999999999*a, h, e};
Point(12) = {a/2, -0.8660253999999999*a, h, e};

/*************************** Cube *****************************/
// Bottom face
Point(13) = {cr, 0, p+h-cr, e}; 
Point(14) = {cr, cr, p+h-cr, e};
Point(15) = {-cr, cr, p+h-cr, e};
Point(16) = {-cr, 0, p+h-cr, e};
Point(17) = {-cr, -cr, p+h-cr, e};
Point(18) = {cr, -cr, p+h-cr, e};
// Top face
Point(19) = {cr, 0, p+h+cr, e};
Point(20) = {cr, cr, p+h+cr, e};
Point(21) = {-cr, cr, p+h+cr, e};
Point(22) = {-cr, 0, p+h+cr, e};
Point(23) = {-cr, -cr, p+h+cr, e};
Point(24) = {cr, -cr, p+h+cr, e};

/********************* 2nd branch (points) *********************/
Point(25) = {a, 0, 2*p+h, e};
Point(26) = {a/2, 0.8660253999999999*a, 2*p+h, e};
Point(27) = {-a/2, 0.8660253999999999*a, 2*p+h, e};
Point(28) = {-a, 0, 2*p+h, e};
Point(29) = {-a/2, -0.8660253999999999*a, 2*p+h, e};
Point(30) = {a/2, -0.8660253999999999*a, 2*p+h, e};

Point(31) = {a, 0, 2*(p+h), e};
Point(32) = {a/2, 0.8660253999999999*a, 2*(p+h), e};
Point(33) = {-a/2, 0.8660253999999999*a, 2*(p+h), e};
Point(34) = {-a, 0, 2*(p+h), e};
Point(35) = {-a/2, -0.8660253999999999*a, 2*(p+h), e};
Point(36) = {a/2, -0.8660253999999999*a, 2*(p+h), e};

/********************* 3rd branch (points) *********************/
Point(37) = {p, 0, p+h+a, e};
Point(38) = {p, -0.8660253999999999*a, p+h+a/2, e};
Point(39) = {p, -0.8660253999999999*a, p+h-a/2, e};
Point(40) = {p, 0, p+h-a, e};
Point(41) = {p, 0.8660253999999999*a, p+h-a/2, e};
Point(42) = {p, 0.8660253999999999*a, p+h+a/2, e};

Point(43) = {p+h, 0, p+h+a, e};
Point(44) = {p+h, -0.8660253999999999*a, p+h+a/2, e};
Point(45) = {p+h, -0.8660253999999999*a, p+h-a/2, e};
Point(46) = {p+h, 0, p+h-a, e};
Point(47) = {p+h, 0.8660253999999999*a, p+h-a/2, e};
Point(48) = {p+h, 0.8660253999999999*a, p+h+a/2, e};

/********************* 1st branch (lines) ***********************/ 
// Lines joining base points
Line(1) = {1,2};
Line(2) = {2,3};
Line(3) = {3,4};
Line(4) = {4,5};
Line(5) = {5,6};
Line(6) = {6,1};
// Lines joining base to top
Line(7) = {1,7};
Line(8) = {2,8};
Line(9) = {3,9};
Line(10) = {4,10};
Line(11) = {5,11};
Line(12) = {6,12};
// Lines joining top points
Line(13) = {7,8};
Line(14) = {8,9};
Line(15) = {9,10};
Line(16) = {10,11};
Line(17) = {11,12};
Line(18) = {12,7};

/*** Lines joining hex face to cube's bottom face ***/
Line(19) = {7,13};
Line(20) = {8,14};
Line(21) = {9,15};
Line(22) = {10,16};
Line(23) = {11,17};
Line(24) = {12,18};

/*** Lines joining up other bits of cube ***/
// Bottom face
Line(25) = {13,14};
Line(26) = {14,15};
Line(27) = {15,16};
Line(28) = {16,17};
Line(29) = {17,18};
Line(30) = {18,13};
// Sides
Line(31) = {14,20};
Line(32) = {15,21};
Line(33) = {17,23};
Line(34) = {18,24};
// Top face
Line(35) = {19,20};
Line(36) = {20,21};
Line(37) = {21,22};
Line(38) = {22,23};
Line(39) = {23,24};
Line(40) = {24,19};

/************************ 2nd branch (lines) ************************/
// Lines joining cube top to the vertices of the bottom face of branch
Line(41) = {19,25};
Line(42) = {20,26};
Line(43) = {21,27};
Line(44) = {22,28};
Line(45) = {23,29};
Line(46) = {24,30};

// Lines joining base points
Line(47) = {25,26};
Line(48) = {26,27};
Line(49) = {27,28};
Line(50) = {28,29};
Line(51) = {29,30};
Line(52) = {30,25};
// Lines joining base to top
Line(53) = {25,31};
Line(54) = {26,32};
Line(55) = {27,33};
Line(56) = {28,34};
Line(57) = {29,35};
Line(58) = {30,36};
// Lines joining top points
Line(59) = {31,32};
Line(60) = {32,33};
Line(61) = {33,34};
Line(62) = {34,35};
Line(63) = {35,36};
Line(64) = {36,31};

/************************** 3rd branch (lines) **********************/
// Lines joining cube side to the the branch
Line(65) = {19,37};
Line(66) = {20,42};
Line(67) = {14,41};
Line(68) = {13,40};
Line(69) = {18,39};
Line(70) = {24,38};
// Bottom face
Line(71) = {37,38};
Line(72) = {38,39};
Line(73) = {39,40};
Line(74) = {40,41};
Line(75) = {41,42};
Line(76) = {42,37};
// Lines joining base to top
Line(77) = {37,43};
Line(78) = {38,44};
Line(79) = {39,45};
Line(80) = {40,46};
Line(81) = {41,47};
Line(82) = {42,48};
// Top face
Line(83) = {43,44};
Line(84) = {44,45};
Line(85) = {45,46};
Line(86) = {46,47};
Line(87) = {47,48};
Line(88) = {48,43};

/************************* Surfaces **************************/
// Bottom branch
// Bottom face
Line Loop(1) = {-1, -6, -5, -4, -3, -2};
// Sides
Line Loop(2) = {1,8,-13,-7};
Line Loop(3) = {2,9,-14,-8};
Line Loop(4) = {3,10,-15,-9};
Line Loop(5) = {4, 11, -16, -10};
Line Loop(6) = {5, 12, -17, -11};
Line Loop(7) = {6, 7, -18, -12};
// Faces joining bottom branch to cube
Line Loop(8) = {13,20,-25,-19};
Line Loop(9) = {14,21,-26,-20};
Line Loop(10) = {15,22,-27,-21};
Line Loop(11) = {16,23,-28,-22};
Line Loop(12) = {17,24,-29,-23};
Line Loop(13) = {18,19,-30,-24};
// Faces of remainder of cube
//Line Loop(14) = {25,31,-35,-40,-34,30};
Line Loop(15) = {26,32,-36,-31};
Line Loop(16) = {28,33,-38,-37,-32,27};
Line Loop(17) = {29,34,-39,-33};
// Faces joining cube to top branch
Line Loop(18) = {35,42,-47,-41};
Line Loop(19) = {36,43,-48,-42};
Line Loop(20) = {37,44,-49,-43};
Line Loop(21) = {38,45,-50,-44};
Line Loop(22) = {39,46,-51,-45};
Line Loop(23) = {40,41,-52,-46};
// Sides around second hex column
Line Loop(24) = {47,54,-59,-53};
Line Loop(25) = {48,55,-60,-54};
Line Loop(26) = {49,56,-61,-55};
Line Loop(27) = {50,57,-62,-56};
Line Loop(28) = {51,58,-63,-57};
Line Loop(29) = {52,53,-64,-58};
// Top face
Line Loop(30) = {59,60,61,62,63,64};

/*********** 3rd branch (surfaces) ***********/
// Faces joining branch to cube
Line Loop(31) = {65,-76,-66,-35};
Line Loop(32) = {66,-75,-67,31};
Line Loop(33) = {67,-74,-68,25};
Line Loop(34) = {68,-73,-69,30};
Line Loop(35) = {69,-72,-70,-34};
Line Loop(36) = {70,-71,-65,-40};

//Line Loop(31) = {-35,-66,-76,65};
//Line Loop(32) = {31,-67,-75,66};
//Line Loop(33) = {25,-68,-74,67};
//Line Loop(34) = {30,-69,-73,68};
//Line Loop(35) = {-34,-70,-72,69};
//Line Loop(36) = {-40,-65,-71,70};
// Sides of branch
Line Loop(37) = {71,78,-83,-77};
Line Loop(38) = {72,79,-84,-78};
Line Loop(39) = {73,80,-85,-79};
Line Loop(40) = {74,81,-86,-80};
Line Loop(41) = {75,82,-87,-81};
Line Loop(42) = {76,77,-88,-82};
// Top face
Line Loop(43) = {83,84,85,86,87,88};

Plane Surface(1) = {1};
Plane Surface(2) = {2};
Plane Surface(3) = {3};
Plane Surface(4) = {4};
Plane Surface(5) = {5};
Plane Surface(6) = {6};
Plane Surface(7) = {7};
Ruled Surface(8) = {8};
Ruled Surface(9) = {9};
Ruled Surface(10) = {10};
Ruled Surface(11) = {11};
Ruled Surface(12) = {12};
Ruled Surface(13) = {13};

//Plane Surface(14) = {14};
Plane Surface(15) = {15};
Plane Surface(16) = {16};
Plane Surface(17) = {17};

Ruled Surface(18) = {18};
Plane Surface(19) = {19};
Ruled Surface(20) = {20};
Ruled Surface(21) = {21};
Plane Surface(22) = {22};
Ruled Surface(23) = {23};

Plane Surface(24) = {24};
Plane Surface(25) = {25};
Plane Surface(26) = {26};
Plane Surface(27) = {27};
Plane Surface(28) = {28};
Plane Surface(29) = {29};

Plane Surface(30) = {30};

Ruled Surface(31) = {31};
Plane Surface(32) = {32};
Ruled Surface(33) = {33};
Ruled Surface(34) = {34};
Plane Surface(35) = {35};
Ruled Surface(36) = {36};

Plane Surface(37) = {37};
Plane Surface(38) = {38};
Plane Surface(39) = {39};
Plane Surface(40) = {40};
Plane Surface(41) = {41};
Plane Surface(42) = {42};

Plane Surface(43) = {43};

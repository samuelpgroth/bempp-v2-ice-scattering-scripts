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
d = 0.25*h;  // total depth of cavity
ds = d/3;    // depth of each step

// Deepest hexagonal face
Point(1) = {0.2, 0, 0+s+d, e};
Point(2) = {0.1, 0.173205081, 0+s+d, e};
Point(3) = {-0.1, 0.173205081, 0+s+d, e};
Point(4) = {-0.2, 0, 0+s+d, e};
Point(5) = {-0.1, -0.173205081, 0+s+d, e};
Point(6) = {0.1, -0.173205081, 0+s+d, e};

Point(7) = {0.2, 0, 0+s+2*ds, e};
Point(8) = {0.1, 0.173205081, 0+s+2*ds, e};
Point(9) = {-0.1, 0.173205081, 0+s+2*ds, e};
Point(10) = {-0.2, 0, 0+s+2*ds, e};
Point(11) = {-0.1, -0.173205081, 0+s+2*ds, e};
Point(12) = {0.1, -0.173205081, 0+s+2*ds, e};
// 2nd hexagonal face
Point(13) = {0.35, 0, 0+s+2*ds, e};
Point(14) = {0.175, 0.303108891, 0+s+2*ds, e};
Point(15) = {-0.175, 0.303108891, 0+s+2*ds, e};
Point(16) = {-0.35, 0, 0+s+2*ds, e};
Point(17) = {-0.175, -0.303108891, 0+s+2*ds, e};
Point(18) = {0.175, -0.303108891, 0+s+2*ds, e};

Point(19) = {0.35, 0, 0+s+ds, e};
Point(20) = {0.175, 0.303108891, 0+s+ds, e};
Point(21) = {-0.175, 0.303108891, 0+s+ds, e};
Point(22) = {-0.35, 0, 0+s+ds, e};
Point(23) = {-0.175, -0.303108891, 0+s+ds, e};
Point(24) = {0.175, -0.303108891, 0+s+ds, e};
// 3rd hexagonal face
Point(25) = {0.5, 0, 0+s+ds, e};
Point(26) = {0.25, 0.433012702, 0+s+ds, e};
Point(27) = {-0.25, 0.433012702, 0+s+ds, e};
Point(28) = {-0.5, 0, 0+s+ds, e};
Point(29) = {-0.25, -0.433012702, 0+s+ds, e};
Point(30) = {0.25, -0.433012702, 0+s+ds, e};

Point(31) = {0.5, 0, 0+s, e};
Point(32) = {0.25, 0.433012702, 0+s, e};
Point(33) = {-0.25, 0.433012702, 0+s, e};
Point(34) = {-0.5, 0, 0+s, e};
Point(35) = {-0.25, -0.433012702, 0+s, e};
Point(36) = {0.25, -0.433012702, 0+s, e};
// Biggest face (bottom)
Point(37) = {1, 0, 0+s, e};
Point(38) = {0.5, 0.8660253999999999, 0+s, e};
Point(39) = {-0.5, 0.8660253999999999, 0+s, e};
Point(40) = {-1, 0, 0+s, e};
Point(41) = {-0.5, -0.8660253999999999, 0+s, e};
Point(42) = {0.5, -0.8660253999999999, 0+s, e};

// Top face (biggest face too)
Point(43) = {1, 0, h+s, e};
Point(44) = {0.5, 0.8660253999999999, h+s, e};
Point(45) = {-0.5, 0.8660253999999999, h+s, e};
Point(46) = {-1, 0, h+s, e};
Point(47) = {-0.5, -0.8660253999999999, h+s, e};
Point(48) = {0.5, -0.8660253999999999, h+s, e};
// 4th hexagonal face
Point(49) = {0.5, 0, h+s, e};
Point(50) = {0.25, 0.433012702, h+s, e};
Point(51) = {-0.25, 0.433012702, h+s, e};
Point(52) = {-0.5, 0, h+s, e};
Point(53) = {-0.25, -0.433012702, h+s, e};
Point(54) = {0.25, -0.433012702, h+s, e};

Point(55) = {0.5, 0, h+s-ds, e};
Point(56) = {0.25, 0.433012702, h+s-ds, e};
Point(57) = {-0.25, 0.433012702, h+s-ds, e};
Point(58) = {-0.5, 0, h+s-ds, e};
Point(59) = {-0.25, -0.433012702, h+s-ds, e};
Point(60) = {0.25, -0.433012702, h+s-ds, e};
// 5th hexagonal face
Point(61) = {0.35, 0, h+s-ds, e};
Point(62) = {0.175, 0.303108891, h+s-ds, e};
Point(63) = {-0.175, 0.303108891, h+s-ds, e};
Point(64) = {-0.35, 0, h+s-ds, e};
Point(65) = {-0.175, -0.303108891, h+s-ds, e};
Point(66) = {0.175, -0.303108891, h+s-ds, e};
Point(67) = {0.35, 0, h+s-2*ds, e};
Point(68) = {0.175, 0.303108891, h+s-2*ds, e};
Point(69) = {-0.175, 0.303108891, h+s-2*ds, e};
Point(70) = {-0.35, 0, h+s-2*ds, e};
Point(71) = {-0.175, -0.303108891, h+s-2*ds, e};
Point(72) = {0.175, -0.303108891, h+s-2*ds, e};
// 6th (deepest) hexagonal face
Point(73) = {0.2, 0, h+s-2*ds, e};
Point(74) = {0.1, 0.173205081, h+s-2*ds, e};
Point(75) = {-0.1, 0.173205081, h+s-2*ds, e};
Point(76) = {-0.2, 0, h+s-2*ds, e};
Point(77) = {-0.1, -0.173205081, h+s-2*ds, e};
Point(78) = {0.1, -0.173205081, h+s-2*ds, e};
Point(79) = {0.2, 0, h+s-d, e};
Point(80) = {0.1, 0.173205081, h+s-d, e};
Point(81) = {-0.1, 0.173205081, h+s-d, e};
Point(82) = {-0.2, 0, h+s-d, e};
Point(83) = {-0.1, -0.173205081, h+s-d, e};
Point(84) = {0.1, -0.173205081, h+s-d, e};

// deepest face
Line(1) = {1,2};
Line(2) = {2,3};
Line(3) = {3,4};
Line(4) = {4,5};
Line(5) = {5,6};
Line(6) = {6,1};
// lines joining deepest face to second deepest
Line(7) = {1,7};
Line(8) = {2,8};
Line(9) = {3,9};
Line(10) = {4,10};
Line(11) = {5,11};
Line(12) = {6,12};
//next face
Line(13) = {7,8};
Line(14) = {8,9};
Line(15) = {9,10};
Line(16) = {10,11};
Line(17) = {11,12};
Line(18) = {12,7};

Line(19) = {13,14};
Line(20) = {14,15};
Line(21) = {15,16};
Line(22) = {16,17};
Line(23) = {17,18};
Line(24) = {18,13};
// lines joining this face to the next
Line(25) = {13,19};
Line(26) = {14,20};
Line(27) = {15,21};
Line(28) = {16,22};
Line(29) = {17,23};
Line(30) = {18,24};
// next face
Line(31) = {19,20};
Line(32) = {20,21};
Line(33) = {21,22};
Line(34) = {22,23};
Line(35) = {23,24};
Line(36) = {24,19};

Line(37) = {25,26};
Line(38) = {26,27};
Line(39) = {27,28};
Line(40) = {28,29};
Line(41) = {29,30};
Line(42) = {30,25};
//lines joining this to next face
Line(43) = {25,31};
Line(44) = {26,32};
Line(45) = {27,33};
Line(46) = {28,34};
Line(47) = {29,35};
Line(48) = {30,36};
//next face
Line(49) = {31,32};
Line(50) = {32,33};
Line(51) = {33,34};
Line(52) = {34,35};
Line(53) = {35,36};
Line(54) = {36,31};

Line(55) = {37,38};
Line(56) = {38,39};
Line(57) = {39,40};
Line(58) = {40,41};
Line(59) = {41,42};
Line(60) = {42,37};

//lines joining bottom to top face
Line(61) = {37,43};
Line(62) = {38,44};
Line(63) = {39,45};
Line(64) = {40,46};
Line(65) = {41,47};
Line(66) = {42,48};
//top face
Line(67) = {43,44};
Line(68) = {44,45};
Line(69) = {45,46};
Line(70) = {46,47};
Line(71) = {47,48};
Line(72) = {48,43};

Line(73) = {49,50};
Line(74) = {50,51};
Line(75) = {51,52};
Line(76) = {52,53};
Line(77) = {53,54};
Line(78) = {54,49};
//lines joining to next face
Line(79) = {49,55};
Line(80) = {50,56};
Line(81) = {51,57};
Line(82) = {52,58};
Line(83) = {53,59};
Line(84) = {54,60};
// next face
Line(85) = {55,56};
Line(86) = {56,57};
Line(87) = {57,58};
Line(88) = {58,59};
Line(89) = {59,60};
Line(90) = {60,55};

Line(91) = {61,62};
Line(92) = {62,63};
Line(93) = {63,64};
Line(94) = {64,65};
Line(95) = {65,66};
Line(96) = {66,61};
//lines joining to next face
Line(97) = {61,67};
Line(98) = {62,68};
Line(99) = {63,69};
Line(100) = {64,70};
Line(101) = {65,71};
Line(102) = {66,72};
//next face
Line(103) = {67,68};
Line(104) = {68,69};
Line(105) = {69,70};
Line(106) = {70,71};
Line(107) = {71,72};
Line(108) = {72,67};

Line(109) = {73,74};
Line(110) = {74,75};
Line(111) = {75,76};
Line(112) = {76,77};
Line(113) = {77,78};
Line(114) = {78,73};
//lines joining to next face
Line(115) = {73,79};
Line(116) = {74,80};
Line(117) = {75,81};
Line(118) = {76,82};
Line(119) = {77,83};
Line(120) = {78,84};
// final face
Line(121) = {79,80};
Line(122) = {80,81};
Line(123) = {81,82};
Line(124) = {82,83};
Line(125) = {83,84};
Line(126) = {84,79};


Line Loop(1) = {-1, -6, -5, -4, -3, -2};
Line Loop(2) = {1,8,-13,-7};
Line Loop(3) = {2,9,-14,-8};
Line Loop(4) = {3,10,-15,-9};
Line Loop(5) = {4, 11, -16, -10};
Line Loop(6) = {5, 12, -17, -11};
Line Loop(7) = {6, 7, -18, -12};
Line Loop(8) = {-13, -18, -17, -16, -15, -14};

Line Loop(9) = {-19, -24, -23, -22, -21, -20};
Line Loop(10) = {19,26,-31,-25};
Line Loop(11) = {20,27,-32,-26};
Line Loop(12) = {21,28,-33,-27};
Line Loop(13) = {22,29,-34,-28};
Line Loop(14) = {23,30,-35,-29};
Line Loop(15) = {24,25,-36,-30};
Line Loop(16) = {-31, -36, -35, -34, -33, -32};

Line Loop(17) = {-37, -42, -41, -40, -39, -38};
Line Loop(18) = {37,44,-49,-43};
Line Loop(19) = {38,45,-50,-44};
Line Loop(20) = {39,46,-51,-45};
Line Loop(21) = {40,47,-52,-46};
Line Loop(22) = {41,48,-53,-47};
Line Loop(23) = {42,43,-54,-48};
Line Loop(24) = {-49, -54, -53, -52, -51, -50};

Line Loop(25) = {-55, -60, -59, -58, -57, -56};
Line Loop(26) = {55,62,-67,-61};
Line Loop(27) = {56,63,-68,-62};
Line Loop(28) = {57,64,-69,-63};
Line Loop(29) = {58,65,-70,-64};
Line Loop(30) = {59,66,-71,-65};
Line Loop(31) = {60,61,-72,-66};
Line Loop(32) = {67,68,69,70,71,72};

Line Loop(33) = {73,74,75,76,77,78};
Line Loop(34) = {73,80,-85,-79};
Line Loop(35) = {74,81,-86,-80};
Line Loop(36) = {75,82,-87,-81};
Line Loop(37) = {76,83,-88,-82};
Line Loop(38) = {77,84,-89,-83};
Line Loop(39) = {78,79,-90,-84};
Line Loop(40) = {85,86,87,88,89,90};

Line Loop(41) = {91,92,93,94,95,96};
Line Loop(42) = {91,98,-103,-97};
Line Loop(43) = {92,99,-104,-98};
Line Loop(44) = {93,100,-105,-99};
Line Loop(45) = {94,101,-106,-100};
Line Loop(46) = {95,102,-107,-101};
Line Loop(47) = {96,97,-108,-102};
Line Loop(48) = {103,104,105,106,107,108};

Line Loop(49) = {109,110,111,112,113,114};
Line Loop(50) = {109,116,-121,-115};
Line Loop(51) = {110,117,-122,-116};
Line Loop(52) = {111,118,-123,-117};
Line Loop(53) = {112,119,-124,-118};
Line Loop(54) = {113,120,-125,-119};
Line Loop(55) = {114,115,-126,-120};
Line Loop(56) = {121,122,123,124,125,126};


//Line Loop(16) = {37, 38, 39, 40, 41, 42};
//Line Loop(17) = {37, 


Plane Surface(1) = {1};
Plane Surface(2) = {2};
Plane Surface(3) = {3};
Plane Surface(4) = {4};
Plane Surface(5) = {5};
Plane Surface(6) = {6};
Plane Surface(7) = {7};
Plane Surface(8) = {-8,-9};
Plane Surface(9) = {10};
Plane Surface(10) = {11};
Plane Surface(11) = {12};
Plane Surface(12) = {13};
Plane Surface(13) = {14};
Plane Surface(14) = {15};
Plane Surface(15) = {-16,-17};
Plane Surface(16) = {18};
Plane Surface(17) = {19};
Plane Surface(18) = {20};
Plane Surface(19) = {21};
Plane Surface(20) = {22};
Plane Surface(21) = {23};
Plane Surface(22) = {-24,-25};
Plane Surface(23) = {26};
Plane Surface(24) = {27};
Plane Surface(25) = {28};
Plane Surface(26) = {29};
Plane Surface(27) = {30};
Plane Surface(28) = {31};
Plane Surface(29) = {32,33};
Plane Surface(30) = {34};
Plane Surface(31) = {35};
Plane Surface(32) = {36};
Plane Surface(33) = {37};
Plane Surface(34) = {38};
Plane Surface(35) = {39};
Plane Surface(36) = {40,41};
Plane Surface(37) = {42};
Plane Surface(38) = {43};
Plane Surface(39) = {44};
Plane Surface(40) = {45};
Plane Surface(41) = {46};
Plane Surface(42) = {47};
Plane Surface(43) = {48,49};
Plane Surface(44) = {50};
Plane Surface(45) = {51};
Plane Surface(46) = {52};
Plane Surface(47) = {53};
Plane Surface(48) = {54};
Plane Surface(49) = {55};
Plane Surface(50) = {56};

//Plane Surface(16) = {16};


//Physical Surface(127) = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50};

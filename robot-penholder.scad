// this part gets gripped in the bracket on the end of the robot's wrist, and holds a pen.
// the wings are for a rubber band to be stretched around, to push the pen downward.
// don't ask me what keeps the pen from falling out when it's lifted away from the paper.

penDiameter = 12.35+0.5; // diameter of a sharpie plus reality correction

grabbedRadius = (1+5/8)*25.4/2; // where the bracket clamps onto it is 1+5/8"
grabbedHeight = (1)*25.4; // clamped part height
hatRadius = (1+5/8+1/2)*25.4/2; // the top hat 
hatHeight = 0.25*25.4; // thickness of hat (everything is printed upside down)

holeHeight = (grabbedHeight+hatHeight)*3; // a cylinder for the marker pen to ride in
holeRadius = penDiameter/2; // radius of the pen hole

$fn = 50; // how many panels make up a cylinder shape

difference() {
  union() { // all these things together are the first line of difference()

	// grabbed part
    translate([0,0,grabbedHeight/2+hatHeight])
		cylinder(r = grabbedRadius, h = grabbedHeight,center=true);

	// brim of "hat" shape
   translate([0,0,hatHeight/2])
		cylinder(r = hatRadius, h = hatHeight+0.001,center=true);
	
	 // wingarm
	translate([0,0,hatHeight/2])
		rotate([0,0,90])
			cube([hatHeight,hatRadius*2+hatHeight*4,hatHeight],center=true);

	 // wing
	translate([hatRadius+hatHeight,hatHeight*1.5,hatHeight/2])
		cube([hatHeight,hatHeight*4,hatHeight],center=true);

	 // wing
	translate([-1*(hatRadius+hatHeight),hatHeight*1.5,hatHeight/2])
		cube([hatHeight,hatHeight*4,hatHeight],center=true);
	}

	// when the robot's manipulator is straight down, the grabbed part is tilted 26 degrees.
	// penhole
	rotate([26,0,0])
		translate([0,7,0])
			cylinder(r = holeRadius, h = holeHeight,center=true);
}

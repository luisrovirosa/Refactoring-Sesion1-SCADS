// this part gets gripped in the bracket on the end of the robot's wrist, and holds a pen.
// the wings are for a rubber band to be stretched around, to push the pen downward.
// don't ask me what keeps the pen from falling out when it's lifted away from the paper.

penDiameter = 12.35 + 0.5; // diameter of a sharpie plus reality correction

grabbedRadius = (1 + 5 / 8) * 25.4 / 2; // where the bracket clamps onto it is 1+5/8"
grabbedHeight = 1 * 25.4; // clamped part height

hatRadius = (1 + (5 / 8) + (1 / 2)) * 25.4 / 2; // the top hat 
hatHeight = 0.25 * 25.4; // thickness of hat (everything is printed upside down)

armHeight = hatHeight;
armMargin = armHeight;
ARM_RELATION_WIDTH_LENGTH = 4;

holeHeight = (grabbedHeight + hatHeight) * 3; // a cylinder for the marker pen to ride in
holeRadius = penDiameter / 2; // radius of the pen hole

RIGTH_ON_Z = [0, 0, 90];
HAT_CORRECTION = 0.001;

$fn = 50; // how many panels make up a cylinder shape

function half(measure) = measure / 2; 

module grabbedPart() {
	offsetZ = half(grabbedHeight) + hatHeight;
	translate([0, 0, offsetZ])
		cylinder(r = grabbedRadius, h = grabbedHeight, center = true);
}

module hat() {
	height = hatHeight + HAT_CORRECTION;
   translate([0, 0, half(hatHeight)])
		cylinder(r = hatRadius, h = height, center = true);
}

module wingarm() {
	armLongitude = 2 * (hatRadius + armMargin + armHeight);
	translate([0, 0, half(hatHeight)])
		rotate(RIGTH_ON_Z)
			cube([armHeight, armLongitude, armHeight], center = true);
}

module rightWing() {
	offsetX = hatRadius + half(armMargin) + half(armHeight);
	offsetY = armHeight * half(ARM_RELATION_WIDTH_LENGTH) - half(armHeight);
	armLength = armHeight * ARM_RELATION_WIDTH_LENGTH;
	translate([offsetX, offsetY, half(hatHeight)])
		cube([armHeight, armLength, armHeight], center = true);
}

module leftWing() {
	translate([-1 * (hatRadius + hatHeight), hatHeight * 1.5, hatHeight / 2])
		cube([hatHeight, hatHeight * 4, hatHeight], center = true);
}

module penHole() {
	// when the robot's manipulator is straight down, the grabbed part is tilted 26 degrees.
	rotate([26,0,0])
		translate([0,7,0])
			cylinder(r = holeRadius, h = holeHeight, center=true);
}

module penHolder() {
	difference() {
		union() { // all these things together are the first line of difference()
			grabbedPart();
			hat();
			wingarm();
			rightWing();
			leftWing();
		}

		penHole();
	}
}

penHolder();
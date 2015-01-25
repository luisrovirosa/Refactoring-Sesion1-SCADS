// this part gets gripped in the bracket on the end of the robot's wrist, and holds a pen.
// the wings are for a rubber band to be stretched around, to push the pen downward.
// don't ask me what keeps the pen from falling out when it's lifted away from the paper.

REALITY_CORRECTION = 0.5;
INCHES = 1;
BRACKET_SIZE = (1 + 5 / 8) * INCHES;

REAL_PEN_DIAMETER = 12.35;
penDiameter = REAL_PEN_DIAMETER + REALITY_CORRECTION;

SCALE = 25.4;

grabbedRadius = radius(BRACKET_SIZE * SCALE);
grabbedHeight = SCALE;

RELATION_HAT_GRABBED = 0.25;
hatRadius = radius((BRACKET_SIZE + REALITY_CORRECTION) * SCALE);
hatHeight = RELATION_HAT_GRABBED * SCALE;

armHeight = hatHeight;
armMargin = armHeight;
ARM_RELATION_WIDTH_LENGTH = 4;

BIG_NUMBER = 3;
holeHeight = (grabbedHeight + hatHeight) * BIG_NUMBER;
holeRadius = radius(penDiameter);
HOLE_INCLINATION = [26, 0, 0];
HOLE_POSITION = [0, 7, 0];

RIGTH_ON_Z = [0, 0, 90];
HAT_CORRECTION = 0.001;

RIGHT_SIDE = 1;
LEFT_SIDE = -1;

MEDIUM_RESOLUTION = 50;
RESOLUTION = MEDIUM_RESOLUTION;
$fn = RESOLUTION;

function half(measure) = measure / 2; 
function radius(diameter) = half(diameter);

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

module wing(SIDE) {
	offsetX = hatRadius + half(armMargin) + half(armHeight);
	offsetY = armHeight * half(ARM_RELATION_WIDTH_LENGTH) - half(armHeight);
	armLength = armHeight * ARM_RELATION_WIDTH_LENGTH;
	translate([SIDE * offsetX, offsetY, half(hatHeight)])
		cube([armHeight, armLength, armHeight], center = true);
}

module rightWing() {
	wing(RIGHT_SIDE);
}


module leftWing() {
	wing(LEFT_SIDE);
}

module penHole() {
	rotate(HOLE_INCLINATION)
		translate(HOLE_POSITION)
			cylinder(r = holeRadius, h = holeHeight, center = true);
}

module structure() {
	union() {
		grabbedPart();
		hat();
		wingarm();
		rightWing();
		leftWing();
	}
}

module penHolder() {
	difference() {
		structure();
		penHole();
	}
}

penHolder();
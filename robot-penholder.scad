// this part gets gripped in the bracket on the end of the robot's wrist, and holds a pen.
// the wings are for a rubber band to be stretched around, to push the pen downward.
// don't ask me what keeps the pen from falling out when it's lifted away from the paper.

REALITY_CORRECTION = 0.5;
INCHES = 1;
BRACKET_SIZE = (1 + 5 / 8) * INCHES;

REAL_PEN_DIAMETER = 12.35;
PEN_DIAMETER = REAL_PEN_DIAMETER + REALITY_CORRECTION;

SCALE = 25.4;

GRABBED_RADIUS = radius(BRACKET_SIZE * SCALE);
GRABBED_HEIGHT = SCALE;

RELATION_HAT_GRABBED = 0.25;
HAT_RADIUS = radius((BRACKET_SIZE + REALITY_CORRECTION) * SCALE);
HAT_HEIGHT = RELATION_HAT_GRABBED * SCALE;

ARM_HEIGHT = HAT_HEIGHT;
ARM_MARGIN = ARM_HEIGHT;
ARM_RELATION_WIDTH_LENGTH = 4;

BIG_NUMBER = 3;
HOLE_HEIGHT = (GRABBED_HEIGHT + HAT_HEIGHT) * BIG_NUMBER;
HOLE_RADIUS = radius(PEN_DIAMETER);
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
	offsetZ = half(GRABBED_HEIGHT) + HAT_HEIGHT;
	translate([0, 0, offsetZ])
		cylinder(r = GRABBED_RADIUS, h = GRABBED_HEIGHT, center = true);
}

module hat() {
	height = HAT_HEIGHT + HAT_CORRECTION;
   translate([0, 0, half(HAT_HEIGHT)])
		cylinder(r = HAT_RADIUS, h = height, center = true);
}

module wingarm() {
	armLongitude = 2 * (HAT_RADIUS + ARM_MARGIN + ARM_HEIGHT);
	translate([0, 0, half(HAT_HEIGHT)])
		rotate(RIGTH_ON_Z)
			cube([ARM_HEIGHT, armLongitude, ARM_HEIGHT], center = true);
}

module wing(SIDE) {
	offsetX = HAT_RADIUS + half(ARM_MARGIN) + half(ARM_HEIGHT);
	offsetY = ARM_HEIGHT * half(ARM_RELATION_WIDTH_LENGTH) - half(ARM_HEIGHT);
	armLength = ARM_HEIGHT * ARM_RELATION_WIDTH_LENGTH;
	translate([SIDE * offsetX, offsetY, half(HAT_HEIGHT)])
		cube([ARM_HEIGHT, armLength, ARM_HEIGHT], center = true);
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
			cylinder(r = HOLE_RADIUS, h = HOLE_HEIGHT, center = true);
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
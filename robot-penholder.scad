penDiameter = (40/64)*25.4; // diameter of the pen

grabbedRadius = (1+5/8)*25.4/2; // where the bracket clamps onto it is 1+5/8"
grabbedHeight = (1)*25.4; // clamped part height
hatRadius = (1+5/8+1/2)*25.4/2; // the top hat 
hatHeight = 0.25*25.4; // thickness of hat (everything is printed upside down)

holeHeight = (grabbedHeight+hatHeight)*3; // a cylinder for the marker pen to ride in
holeRadius = penDiameter/2; // radius of the pen hole

difference() {
  union() { // all these things together are the first line of difference()

    translate([0,0,grabbedHeight/2+hatHeight]) cylinder(r = grabbedRadius, h = grabbedHeight,center=true); // grabbed part
    translate([0,0,hatHeight/2]) cylinder(r = hatRadius, h = hatHeight+0.001,center=true); // brim of "hat" shape

//    translate([75,-130,20]) cylinder(r = 7, h = 40,center=true); // foot
//    translate([0,0,10]) cube([80,100,20],center=true); // torso box
//    translate([0,80,0]) cylinder(r = 25, h = 25); // head
//    translate([-75,-130,20]) cylinder(r = 7, h = 40,center=true); // foot
//    sphere(40); // top half of a sphere
  }
  // when the robot's manipulator is straight down, the grabbed part is tilted 26 degrees.
  rotate([26,0,0]) translate([0,7,0]) cylinder(r = holeRadius, h = holeHeight,center=true); // penhole
// translate([0,0,-150]) cube(300,center=true); // subtract everything below sea level
}

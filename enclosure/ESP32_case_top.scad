use <round_cube.scad>

/* case outer length */
length = 56+6.5;

/* case outer width */
width  = 30.5+2.6;

difference() {
    union() {
        /* top part of the case */
        difference() {
            /* bottom rounded corners plate */
            roundCornersCube(length, width, 2.0, 3);
            /* the two holes for the buttons */
            translate([7.0,9.0,-0.1]) cylinder(d=3, h=2.2, $fn=60);
            translate([7.0,width-9.0,-0.1]) cylinder(d=3, h=2.2, $fn=60);
            /* wifi logo */
            /*translate([length-28,width/2 + 13,-0.1]) rotate([0, 0, 270]) linear_extrude(height =2.2) import(file = "wifi.dxf", layer = "wifi");*/
        }
        
        /* mid part */
        translate([0, 0, 2]) difference() {
            roundCornersCube(length, width, 0.5, 3);
            translate([1.75+1.65, 0.8+1.65, -0.1]) roundCornersCube(length-1.65*2-1.75*2, width-1.65*2-0.8*2, 0.7, 1.65);
            translate([-0.1, width/2-12/2, -0.1]) cube([1.75+1.65+0.2, 12, 0.7]);
        }

        /* top rim */
        translate([0, 0, 2.5]) {
            union() {
                difference() {
                    roundCornersCube(length, width, 4.0, 3);
                    translate([1.55, 1.65, -0.1]) roundCornersCube(length-1.45*2, width-1.65*2, 4.2, 1.65);
                    translate([-0.1, width/2-12/2, -0.1]) cube([1.75+1.65+0.2, 12, 5.2]);
                }
                /*translate([1.5, 5+1.65, 2]) sphere(r = 1, $fn=60);
                translate([1.5, width-1.65-5, 2]) sphere(r = 1, $fn=60);
                translate([length-1.5, 5+1.65, 2]) sphere(r = 1, $fn=60);
                translate([length-1.5, width-1.65-5, 2]) sphere(r = 1, $fn=60);*/
            }
        }
    }
    
}



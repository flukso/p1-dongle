use <round_cube.scad>

/* case outer length */
length = 56+6.5;

/* case outer width */
width  = 30.5+2.6;

difference() {
    union() {
        /* bottom part of the case */
        roundCornersCube(length, width, 2.0, 3);

        /* mid part */
        translate([0, 0, 2]) difference() {
            roundCornersCube(length, width, 5.0, 3);
            translate([1.75+1.65, 0.8+1.65, -0.1]) roundCornersCube(length-1.65*2-1.75*2, width-1.65*2-0.8*2, 5.2, 1);
        }


        
        /* corner blocks */
        translate([1.75+1.65, 0.8+1.65, 2]) {
            cube([2.5, 3.5, 5]);
        }
        translate([1.75+1.65, width-0.8-1.65-1.0-2.5, 2]) {
            cube([2.5, 3.5, 5]);
        }
        translate([length-1.75-1.65-2.5, 0.8+1.65, 2]) {
            cube([2.5, 3.5, 5]);
        }
        translate([length-1.75-1.65-2.5, width-0.8-1.65-1-2.5, 2]) {
            cube([2.5, 3.5, 5]);
        }
        

        /* rim */
        translate([1.75, 1.65, 7]) difference() {
            roundCornersCube(length-1.75*2, width-1.65*2, 4.0, 1.65);
            translate([1.65, 0.8, -0.1]) roundCornersCube(length-1.65*2-1.75*2, width-1.65*2-0.8*2, 4.2, 1);
            translate([-0.1, width/2-12/2-1.65, -0.1]) cube([1.95, 12, 4.2]);
        }
    }
    
    translate([length/2 - 2.5, 0, 4.8]) cube([5.0, 10.0, 10.0]);
}



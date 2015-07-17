/*

 Copyright (C) 2014 Robert Kaye
 Creative Commons License 3.0 BY-SA

 This coffee cup shim can be customized!

 Adjust the following values to fit the cups/coffee equipment you have.
*/

// The outer (plate) diameter of the shim. This should a few mm wider than your coffee cups:
plate_dia = 195; // mm

width = 68;

// The inner diameter of the shim. This should be a few mm larger than the outer diameter of
// your coffee filter cone or Aeropress:
inner_dia = plate_dia - width; // mm

// How thick the main plate should be. 3mm seems sturdy.
plate_thickness = 3.0;

// The number of facets to use to render the cylinders. 25 is good for tinkering, 100+ for a final part.
facets = 100;
num_pegs = 12;

spacing = 28.3; //mm apart

bolt_dia = 5.2; 

//5mm * 5mm wide/deep
//12 mm tall

// No need to edit below this line -------
plate_r = plate_dia / 2;
inner_r = inner_dia / 2;
bolt_r = bolt_dia / 2;

peg_offset = plate_dia - 39;
hole_offset = (plate_dia - 50) / 2;

//intersection()
//{
	//plate();
ring();
//	translate([-2.5, 60, -12])
//    		cube([20,50,30]);
//}

module plate()
{
	ring();

	for (i = [0:num_pegs]) 
    		assign(deg = (360 / num_pegs) * i)
		{
			translate( [(peg_offset / 2) * sin(deg), (peg_offset / 2) * cos(deg), 0] ) 
				rotate([0,0,-deg])
					pegs();
		}
}

module pegs()
{
	translate([0, -spacing / 2,plate_thickness])
    difference()
	{
		cube([10,5,12]);
		translate([-2, 2.5, 6])
			rotate([0,90,0])
				cylinder(h = 10, r = 1, $fn=facets);
	}
	translate([0, spacing / 2,plate_thickness])
    difference()
	{
		cube([10,5,12]);
		translate([-2, 2.5, 6])
			rotate([0,90,0])
				cylinder(h = 10, r = 1, $fn=facets);
	}
}

module ring()
{
	difference()
	{
		difference()
		{
			cylinder(h = plate_thickness, r = plate_r, $fn=facets);
			translate([0,0,-.05])
				cylinder(h = plate_thickness + .1, r = inner_r, $fn=facets);
		}

		rotate([0,0,12])
			union()
			{
				translate([-hole_offset, 0, -.1])
		    			cylinder(h = plate_thickness * 2, r = bolt_r, $fn=facets);
				translate([hole_offset, 0, -.1])
		    			cylinder(h = plate_thickness * 2, r = bolt_r, $fn=facets);
				translate([0, -hole_offset, -.1])
		    			cylinder(h = plate_thickness * 2, r = bolt_r, $fn=facets);
				translate([0, hole_offset, -.1])
		    			cylinder(h = plate_thickness * 2, r = bolt_r, $fn=facets);
			}
	} 
}


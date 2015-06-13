
plate_dia = 90; // mm

// The outer diameter of the ridge that fits inside the coffee cup:
ridge_dia = 65; // mm

// How thick the main plate should be. 3mm seems sturdy.
plate_thickness = 3;

// The number of facets to use to render the cylinders. 25 is good for tinkering, 100+ for a final part.
facets = 100;

//holes: 58mm wide
//       49 mm wide

standoff_height = 7.0;
standoff_id = 3.0;
standoff_od = 5.0;

plate_hole_size = 3; // a square 

// No need to edit below this line -------
plate_r = plate_dia / 2;
ridge_r = ridge_dia / 2;

union()
{
	translate([0,0,-plate_thickness])
	difference() 
	{
		cylinder(h = plate_thickness, r = plate_r, $fn=facets);
		color([1,0,0])
		translate([0,-30,0])
			cube(plate_hole_size, plate_hole_size, plate_thickness + 2); 
	}
    // internal ride -- nice to have, hard to print. :(
    //cylinder(h = plate_thickness, r = ridge_r, $fn=facets);

	translate([0, 3, -(standoff_height + plate_thickness)])
		union()
		{
		    standoff(29, 24.5);
			standoff(29, -24.5);
			standoff(-29, -24.5);
			standoff(-29, 24.5);
		}
}

module standoff(x, y)
{
	translate([x, y])
    		difference()
		{
			cylinder(h = standoff_height, r = standoff_od / 2, $fn=facets);
			cylinder(h = standoff_height, r = standoff_id / 2, $fn=facets);
		}
}
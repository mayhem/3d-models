/*

 Copyright (C) 2014 Robert Kaye
 Creative Commons License 3.0 BY-SA

 This coffee cup shim can be customized!

 Adjust the following values to fit the cups/coffee equipment you have.
*/

// The outer (plate) diameter of the shim. This should a few mm wider than your coffee cups:
plate_dia = 114; // mm

// The outer diameter of the ridge that fits inside the coffee cup:
ridge_dia = 97; // mm

// The inner diameter of the shim. This should be a few mm larger than the outer diameter of
// your coffee filter cone or Aeropress:
inner_dia = 70; // mm

// How thick the main plate should be. 3mm seems sturdy.
plate_thickness = 3;

// How thick the ridge on the main plate should be. 2mm keeps it from sliding off the cup
ridge_thickness = 2;

// The number of facets to use to render the cylinders. 25 is good for tinkering, 100+ for a final part.
facets = 100;

// No need to edit below this line -------
plate_r = plate_dia / 2;
ridge_r = ridge_dia / 2;
inner_r = inner_dia / 2;

union()
{
	translate([0,0,-plate_thickness])
		upper_cylinder();
    lower_cylinder();
}

module upper_cylinder()
{
	difference()
	{
		cylinder(h = plate_thickness, r = plate_r, $fn=facets);
		cylinder(h = plate_thickness, r = inner_r, $fn=facets);
	}; 
}

module lower_cylinder()
{
    	difference()
	{
		cylinder(h = ridge_thickness, r = ridge_r, $fn=facets);
		cylinder(h = ridge_thickness, r = inner_r, $fn=facets);
	};
}
center_hole_r = 7.5;
lower_r = 34.25;
upper_r = 23;
upper_thickness = 5.3;
lower_rim = 3;
height = 12.5;
facets = 200;

lid_knob();

module lid_knob()
{
    difference()
	{
		cylinder(h = height, r1 = lower_r, r2 = upper_r, center = true, $fn = facets);
		union()
		{
			translate([0, 0, (-upper_thickness/2) -.01])
				cylinder(h = height - (upper_thickness / 2) + 1, r1 = lower_r - lower_rim, r2 = center_hole_r, 
                         center = true, $fn = facets);
			translate([0, 0, upper_thickness])
				cylinder(h = upper_thickness, r1 = center_hole_r, r2 = center_hole_r, center = true, $fn = facets);
		}
	}
}

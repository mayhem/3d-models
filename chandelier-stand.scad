rod_dia = 13.3;
rod_inner_dia = 10;
num_rings = 2;


center_hole_dia = 8.1;
center_offset = 10;
spacing_mult = 1.5;
mounting_hole_dia = 5.0;
mounting_hole_offset = 65;
mounting_hole_rotation = 17;

bottle_mount_height = 40;
bottle_mount_dia = 33;
bottle_dia = 51.5;
bottle_slope_height = 10;
bottle_facets = 20;
bottle_height = 120;
bottle_top_dia = 41;
bottle_top_height = 5;

rod_counts = [ [13, 305, 10], [10, 610, 7], [13, 915, 0] ];
rod_facets = 64;

base_radius = 70;
base_height = 20;
middle_height = 10;
middle_radius = 85;
middle_offset = 100;

//only_base();
only_middle();
//whole();

module whole()
{
    base();
	middle();
    arms();
}

module only_base()
{
	difference()
	{
		base();
		arms();
	}
}

module only_middle()
{
	difference()
	{
		middle();
		arms();
	}
}

module arms()
{
	for(ring = [0:num_rings - 1])
	{
	    assign(count = rod_counts[ring][0])
		assign(length = rod_counts[ring][1])
		assign(angle = rod_counts[ring][2])
		for (i = [0:count])
		{ 
			assign(deg = (360 / count) * i)
			rotate([0, 0, deg])
				rotate([0,angle, 0])
					translate([-center_offset + rod_dia * spacing_mult * (num_rings - ring + 1),0,0])
						arm(length);
		}
	}
}

module base_mounting_holes()
{
	rotate([0,0, mounting_hole_rotation])
	union()
	{
		translate([mounting_hole_offset, 0, 0])
			cylinder(h = base_height + .01, r = mounting_hole_dia / 2, center=true, $fn = 32);
		translate([-mounting_hole_offset, 0, 0])
			cylinder(h = base_height + .01, r = mounting_hole_dia / 2, center=true, $fn = 32);
		translate([0, mounting_hole_offset, 0])
			cylinder(h = base_height + .01, r = mounting_hole_dia / 2, center=true, $fn = 32);
		translate([0, -mounting_hole_offset, 0])
			cylinder(h = base_height + .01, r = mounting_hole_dia / 2, center=true, $fn = 32);
	}
}

module middle()
{
	translate([0,0, middle_offset])
		difference()
		{
			cylinder(h = middle_height, r = middle_radius, center=true, $fn = 64);
			cylinder(h = middle_height + .01, r = center_hole_dia / 2, center=true, $fn = 32);
	    }
}

module base()
{
	difference()
	{
		cylinder(h = base_height, r = base_radius, center=true, $fn = 64);
		cylinder(h = base_height + .01, r = center_hole_dia / 2, center=true, $fn = 32);
		base_mounting_holes();
    }
}

module arm(arm_length)
{
	translate([0,0,arm_length/2])
	    union()
		{
			color([.2,.2,.2])
				union()
				{
					cylinder(h = arm_length, r = rod_dia / 2, center=true, $fn = rod_facets);
					cylinder(h = arm_length + 20, r = rod_inner_dia / 2, center=true, $fn = rod_facets);
				}
		
			color(rands(.6,.9, 3))
				union()
				{
					translate([0, 0, arm_length / 2 + bottle_mount_height / 2])
						cylinder(h = bottle_mount_height, r = bottle_mount_dia / 2, center = true, $fn = bottle_facets);
					translate([0, 0, arm_length / 2 + bottle_mount_height + bottle_slope_height / 2])
						cylinder(h = bottle_slope_height, r1 = bottle_mount_dia / 2, r2 = bottle_dia / 2, 
								center=true, $fn = bottle_facets);
					translate([0, 0, arm_length / 2 + bottle_mount_height + bottle_slope_height + bottle_height / 2])
						cylinder(h = bottle_height, r = bottle_dia / 2, center=true, $fn = bottle_facets);
					translate([0, 0, arm_length / 2 + bottle_mount_height + bottle_slope_height + bottle_height + bottle_top_height / 2])
						cylinder(h = bottle_top_height, r1 = bottle_dia / 2, r2 = bottle_top_dia / 2, center=true, $fn = bottle_facets);
				}
		}
}
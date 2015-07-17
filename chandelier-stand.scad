rod_dia = 13.3;
num_rings = 3;
base_height = 100;

bottle_mount_height = 40;
bottle_mount_dia = 33;
bottle_dia = 51.5;
bottle_slope_height = 10;
bottle_facets = 20;
bottle_height = 120;
bottle_top_dia = 41;
bottle_top_height = 5;

rod_counts = [ 13, 17, 19 ];

rod_facets = 16;

// calculate the effective_rod_dia

// calculate the base_radius
base_radius = 300;

arm(100);

module base()
{
	cylinder(h = base_height, r = base_radius, center=true, $fn = 20); 
}

module arm(arm_length)
{
	color([.2,.2,.2])
		cylinder(h = arm_length, r = rod_dia / 2, center=true, $fn = rod_facets);

	color([.7,.7,.7])
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


body_depth = 83;
body_width  = 55;
body_height = 20;


wall_thickness = 5;
body_width_outer  = body_width + (wall_thickness * 2);
body_height_outer  = body_height + (wall_thickness * 2);
slot_width = .40;
slot_wall_depth = 3;
slot_wall_height = 1.5;
slot_floor = 6;

shell_outer = 63;
floor_thickness = 3;

main_body();


module main_body()
{
	union()
	{
		intersection()
		{
			union()
			{
				translate([0,-6,0])
					body();
				translate([0,0,-(body_depth / 2 - (floor_thickness/2))])
					cube([shell_outer * 2, shell_outer * 2, floor_thickness], center=true);
			}
			rotate([0,0,22.5])
				solid_shell();
		}
	    rotate([0,0,22.5])
	    		shell();
	}
}

module body()
{
	difference()
	{
		cube([body_width_outer, body_height_outer, body_depth], center=true);
		cube([body_width, body_height, body_depth + 1], center=true);  
	}
	translate([0, -((body_height / 2) - slot_floor), 0])
		slots();
}

module slots()
{
    	translate([(body_width / 2), slot_wall_height + (slot_width / 2), 0])
    		cube([slot_wall_depth, slot_wall_height, body_depth], center=true);
    translate([(body_width / 2), -(slot_wall_height + (slot_width / 2)), 0])
    		cube([slot_wall_depth, slot_wall_height, body_depth], center=true);

    	translate([-(body_width / 2), slot_wall_height + (slot_width / 2), 0])
    		cube([slot_wall_depth, slot_wall_height, body_depth], center=true);
    translate([-(body_width / 2), -(slot_wall_height + (slot_width / 2)), 0])
    		cube([slot_wall_depth, slot_wall_height, body_depth], center=true);
}	

module shell()
{
	difference()
	{
		solid_shell();
		cylinder(h = body_depth + 1, d = shell_outer, $fn = 8, center=true);
	}
}

module solid_shell()
{
	cylinder(h = body_depth, d = shell_outer + (wall_thickness * 2), $fn = 8, center=true);
}
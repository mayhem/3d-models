

body_depth = 26; //81;
body_width  = 55;
body_height = 20;


wall_thickness = 5;
body_width_outer  = body_width + (wall_thickness);
body_height_outer  = body_height + (wall_thickness);
slot_width = .38;
slot_wall_depth = 3;
slot_wall_height = 1.5;
slot_floor = 6;

body_in_shell_offset = 6;

shell_outer = 63;
floor_thickness = 2;

led_dia = 10;
column_thickness = 7;
column_depth = 18;
screw_hole_dia = 1.5;

lid_thickness = 3;
lid_screw_hole_dia = 2.5;
lid_screw_recess_uppder_dia = 5;
lid_screw_hole_depth = 2.0;

switch_width = 19;
switch_height = 7;

battery_width = 28;
battery_height = 19.5;

//main_body();
//translate([0,0,50])
lid();

module main_body()
{
	union() // glue on the shell
	{
		intersection() // cut off things that overlap outside
		{
			difference() // cut out LED
			{
				union() // body & floor
				{
					translate([0,-body_in_shell_offset,0])
						body();
					translate([0,0,-(body_depth / 2 - (floor_thickness/2))])
						cube([shell_outer * 2, shell_outer * 2, floor_thickness], center=true);
				}
				translate([0,0,-(body_depth / 2 - (floor_thickness/2))])
					cylinder(h = body_depth * 3, d = led_dia, center=true, $fn = 20);
			}
			rotate([0,0,22.5])
				solid_shell();
		}
	    rotate([0,0,22.5])
	    		shell();
	}
}

module lid()
{
	// lid
	difference()
	{
		intersection()
		{
			cube([shell_outer * 2, shell_outer * 2, lid_thickness], center=true);
			rotate([0,0,22.5])
				solid_shell();
		}
		translate([0,-body_in_shell_offset,0])
			union()
			{
				translate([(body_width / 2), body_height - wall_thickness, 0])
					lid_screw_hole();
				translate([-(body_width / 2), body_height - wall_thickness, 0])
					lid_screw_hole();
				translate([-((body_width / 2) - (column_thickness * 2 / 3)), 
                            -(body_height - body_in_shell_offset), 0])
					lid_screw_hole();
				translate([((body_width / 2) - (column_thickness * 2 / 3)), 
                            -(body_height - body_in_shell_offset), 0])
					lid_screw_hole();
			}
		// switch hole
		translate([0, -(body_height - (wall_thickness / 2)), 0])
			cube([switch_width, switch_height, switch_height], center=true);
	}
    // handle
	difference()
	{
		rotate([0,90,90])
				rotate_extrude($fn = 80)
					translate([10, 0, 0])
						circle(r = 2, $fn = 40);
		translate([0, 0, -(10*lid_thickness)])
			cube([body_width, body_width, (20*lid_thickness)], center=true);
	}
	
}

module lid_screw_hole()
{
	cylinder(h = body_depth, d = lid_screw_hole_dia, center=true, $fn = 20);
	translate([0, 0, lid_thickness / 2 ])
		cylinder(h = lid_screw_hole_depth, r1 = lid_screw_hole_dia / 2, r2 = lid_screw_recess_uppder_dia / 2, center=true, $fn = 20);
}

module column()
{
	translate([0,0,(body_depth /2) - (column_depth / 2)])
    union()
	{
		difference()
		{
			cylinder(h = column_depth, d = column_thickness, center=true, $fn = 20);
			cylinder(h = column_depth, d = screw_hole_dia, center=true, $fn = 20);
		}
		translate([0, 2.0, -column_depth / 1.5])
			rotate([25, 0, 0])
			color([1,0,0])
			cylinder(h = column_depth / 2.00, r1 = .01, r2 = column_thickness * 1.52 / 3 , center=true, $fn = 20);
	}
}

module fastener_columns()
{
	translate([(body_width / 2), body_height - wall_thickness, 0])
		rotate([0,0,-130])
			column();
	translate([-(body_width / 2), body_height - wall_thickness, 0])
		rotate([0,0,130])
			column();
    // IMPORTANT: Make any changes above as well. Or better yet, refactor!
	translate([-((body_width / 2) - (column_thickness * 2 / 3)), -(body_height - body_in_shell_offset), 0])
		rotate([0,0,60])
			column();
	translate([((body_width / 2) - (column_thickness * 2 / 3)), -(body_height - body_in_shell_offset), 0])
		rotate([0,0,-60])
			column();
}

module body()
{
	difference()
	{
		union()
		{
			difference()
			{
				cube([body_width_outer, body_height_outer, body_depth], center=true);
				cube([body_width, body_height, body_depth + 1], center=true);
		    }
			// battery case
		    	translate([0,body_height + (wall_thickness / 1.6),0])
			    	difference()
				{	
					color([1,0,0])
					cube([battery_width + 2, battery_height + 2, body_depth], center=true);
					cube([battery_width, battery_height, body_depth + 1], center=true); 
			    }
	 	}
		translate([body_width / 5.5, body_height - (body_height / 2), body_depth / 2])
			rotate([90, 0, 0])
				cylinder(h = wall_thickness * 3, d = 7, center=true, $fn=10);
		translate([body_width / 3.5, -(body_height - (body_height / 2)), body_depth / 2])
			rotate([90, 0, 0])
				cylinder(h = wall_thickness * 3, d = 7, center=true, $fn=10);
	}

	translate([0, -((body_height / 2) - slot_floor), 0])
		slots();
	fastener_columns();
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
		cylinder(h = body_depth + 1, d = shell_outer, $fn = 16, center=true);
	}
}

module solid_shell()
{
	cylinder(h = body_depth, d = shell_outer + (wall_thickness * 1.35), $fn = 16, center=true);
}
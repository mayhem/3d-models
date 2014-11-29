

body_depth = 83;
body_width  = 55;
body_height = 20;


wall_thickness = 5;
body_width_outer  = body_width + (wall_thickness * 2);
body_height_outer  = body_height + (wall_thickness * 2);
slot_width = .38;
slot_wall_depth = 3;
slot_wall_height = 1.5;
slot_floor = 6;

body_in_shell_offset = 6;

shell_outer = 63;
floor_thickness = 2;

led_dia = 7;
column_thickness = 7;
screw_hole_dia = 1.5;

lid_thickness = 3;
lid_screw_hole_dia = 2.5;
lid_screw_recess_uppder_dia = 5;
lid_screw_hole_depth = 2.0;

//main_body();
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
					cylinder(h = floor_thickness * 3, d = led_dia, center=true, $fn = 20);
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
				translate([(body_width / 2), body_height - (wall_thickness / 2), 0])
					lid_screw_hole();
				translate([-(body_width / 2), body_height - (wall_thickness / 2), 0])
					lid_screw_hole();
				translate([0, -(body_height - body_in_shell_offset + (screw_hole_dia * 2)), 0])
					lid_screw_hole();
			}
	}
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
	difference()
	{
		cylinder(h = body_depth, d = column_thickness, center=true, $fn = 20);
		cylinder(h = body_depth, d = screw_hole_dia, center=true, $fn = 20);
	}
}

module fastener_columns()
{
	translate([(body_width / 2), body_height - (wall_thickness / 2), 0])
		column();
	translate([-(body_width / 2), body_height - (wall_thickness / 2), 0])
		column();
	translate([0, -(body_height - body_in_shell_offset + (screw_hole_dia * 2)), 0])
		column();
}

module body()
{
	difference()
	{
		cube([body_width_outer, body_height_outer, body_depth], center=true);
		cube([body_width, body_height, body_depth + 1], center=true);  
	translate([0, body_height - (body_height / 2), body_depth / 2])
		rotate([90, 0, 0])
			cylinder(h = wall_thickness * 3, d = 3, center=true, $fn=10);
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
		cylinder(h = body_depth + 1, d = shell_outer, $fn = 8, center=true);
	}
}

module solid_shell()
{
	cylinder(h = body_depth, d = shell_outer + (wall_thickness * 1.), $fn = 256, center=true);
}
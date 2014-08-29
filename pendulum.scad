wall_tickness = 5;
bowl_thickness = 5;

board_edge = 21;
board_ceil = 25;

bowl_radius = board_edge * 2;
bowl_hole_radius = 1.5;

conn_x = 17;
conn_y = 5;

facets = 200;

difference()
{
	main_body();
	translate([0,0,-bowl_hole_radius * 4])
		rotate([90, 0, 0])
			cylinder(h = bowl_radius * 2, r1 = bowl_hole_radius, r2 = bowl_hole_radius,center = true, $fn=facets);
	translate([0,0,-bowl_hole_radius * 4])
		rotate([90, 0, 90])
			cylinder(h = bowl_radius * 2, r1 = bowl_hole_radius, r2 = bowl_hole_radius,center = true, $fn=facets);
}

module main_body()
{
	difference()
	{
		main_body_no_slot();
		translate([0, wall_tickness,-bowl_radius])
    			color([1, 0, 1])
				cube([conn_x, conn_y, board_edge], center=true, $fn=facets);
	}
}

module main_body_no_slot()
{
	translate([0, 0, -((board_ceil / 2) + bowl_radius - 1)])
		pcb_box();
	bowl();
}

module bowl()
{
	difference()
	{
 		color([1,0,0]) 
			sphere(bowl_radius, center=true, $fn=facets);

		color([0,0,1])
			translate([0, 0, bowl_radius /2])
				cylinder(h = bowl_radius, r1 = bowl_radius, r2 = bowl_radius, center=true, $fn=facets);

		color([0,1,0])
			sphere(bowl_radius - (bowl_thickness / 2), center=true, $fn=facets);
	}
}

module pcb_box()
{
	translate([-(wall_tickness / 4), 0, 0])
		difference()
		{
 			color([1,0,0]) 
				cube([board_edge + wall_tickness, board_edge + wall_tickness, board_ceil + wall_tickness], center=true, $fn=facets);

			color([0,0,1])
				translate([(wall_tickness / 4), 0, 0])
					cube([board_edge + 10, board_edge, board_ceil], center=true, $fn=facets);
		}
}
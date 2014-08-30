wall_tickness = 5;
bowl_thickness = 5;

board_edge = 21;
board_ceil = 25;

bowl_radius = board_edge * 2;
hanger_radius = bowl_thickness / 3;
hanger_height = 65;
hanger_leg_rotation = 35;
hanger_vert_offset = 20;
hanger_ball_offset = 48;
ball_radius = (hanger_radius * 2) + .5;

conn_x = 17;
conn_y = 5;

facets = 200;

main_body();
rotate([0,0,45])
	hanger();

module hanger()
{
	difference()
	{
		union()
		{
			translate([bowl_radius / 2, 0, hanger_vert_offset])
				rotate([0, -hanger_leg_rotation, 0])	
					hanger_leg();
			translate([-bowl_radius / 2, 0, hanger_vert_offset])
				rotate([0, hanger_leg_rotation, 0])	
					hanger_leg();
			translate([0, bowl_radius / 2, hanger_vert_offset])
				rotate([hanger_leg_rotation, 0, 0])	
					hanger_leg();
			translate([0, -bowl_radius / 2, hanger_vert_offset])
				rotate([-hanger_leg_rotation, 0, 0])	
					hanger_leg();
		    translate([0, 0, hanger_ball_offset])
				sphere(ball_radius, center=true, $fn=facets);
		}
	 	translate([0,0,hanger_ball_offset + 2.5])
	    		rotate([0,90,45])
				rotate_extrude($fn = facets)
					translate([4, 0, 0])
						circle(r = 1, $fn = facets);
	}
}

module hanger_leg()
{
	color([1,.5,0])
		cylinder(h = hanger_height, r1 = hanger_radius, r2 = hanger_radius, center=true, $fn=facets);
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
	translate([0, 0, 0])
		difference()
		{
 			color([1,0,0]) 
				cube([board_edge + wall_tickness, board_edge + wall_tickness, board_ceil + wall_tickness], center=true, $fn=facets);

			color([0,0,1])
				translate([(wall_tickness / 4), 0, 0])
					cube([board_edge + 10, board_edge, board_ceil], center=true, $fn=facets);
		}
}
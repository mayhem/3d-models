wall_tickness = 5;
bowl_thickness = 5;

board_edge = 21;
board_ceil = 25;

bowl_radius = board_edge * 2;
hanger_radius = bowl_thickness / 2;
hanger_height = 65;
hanger_leg_rotation = 35;
hanger_vert_offset = 20;
hanger_ball_offset = 48;
ball_radius = (hanger_radius * 2) + 3;

conn_side = 5;

facets = 200;

difference()
{
	union()
	{
		bowl();
		translate([0, 0, -70.7])
			pcb_box();
	}


	translate([0, 0,-bowl_radius - 20])
		color([1, 1, 0])
			cylinder(h = 20, r1 = conn_side, r2 = conn_side, center=true, $fn=facets);
}

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
	 	translate([0,0,hanger_ball_offset + 7.5])
	    		rotate([0,90,45])
				rotate_extrude($fn = facets)
					translate([10, 0, 0])
						circle(r = 2, $fn = facets);
	}
}

module hanger_leg()
{
	color([1,.5,0])
		cylinder(h = hanger_height, r1 = hanger_radius, r2 = hanger_radius, center=true, $fn=facets);
}

module bowl()
{
	difference()
	{
		scale([1, 1, 1.5])
 			color([1,0,0]) 
				sphere(bowl_radius, center=true, $fn=facets);

		color([0,1,1])
			translate([0, 0, -bowl_radius + 78])
				cylinder(h = 80, r1 = bowl_radius +1, r2 = bowl_radius+1, center=true, $fn=facets);

		color([0,0,1])
			translate([0, 0, -bowl_radius - 19])
				cylinder(h = 5, r1 = bowl_radius +1, r2 = bowl_radius+1, center=true, $fn=facets);

		scale([1, 1, 1.5])
			color([0,1,0])
				sphere(bowl_radius - (bowl_thickness / 2), center=true, $fn=facets);

	}
}

module pcb_box()
{
	difference()
	{
 		color([1,0,0]) 
			cylinder(h = board_ceil + wall_tickness, 
					r1 = (board_edge / 2) + wall_tickness, 
                        r2 = (board_edge / 2) + wall_tickness, center=true, $fn=facets);

		color([0,0,1])
			translate([(wall_tickness / 4), 0, 0])
				cube([board_edge * 2, board_edge, board_ceil], center=true, $fn=facets);
	}
}
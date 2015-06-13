height = 10;
box_width = 7.5;
box_height = 2.3;
box2_height = 2.6;

socket_height = 21;
socket_radius = 4.5;

base_radius = 10;
base_height = 1.5;

facets = 50;

socket();
shaft();

module socket()
{
	difference()
	{
		union()
		{
			translate([0, 0, -((height / 2) + (socket_height / 2))]) 
				cylinder(h = socket_height, r1 = socket_radius, r2 = socket_radius, center=true, $fn=facets);
			translate([0, 0, -((height / 2) + socket_height - (base_height / 2))])
				cylinder(h = base_height, r1 = base_radius, r2 = base_radius, center=true, $fn=facets);
		}
		translate([0,0,-3])
			difference()
			{
				color([1,0,0])
					translate([0, 0, -(((height / 2) + (socket_height / 2)))])
						cylinder (h=socket_height,r=socket_radius-1.6, center=true,$fn=facets );
				color([0,0,1])
					translate([4.6, 0, -((height / 2) + (socket_height / 2))])
						cube ([5,5,socket_height], center=true);
			}
	}
}

module shaft()
{
	cube([box_width, box_height, height], center=true);
    rotate(90, 0, 0)
		cube([box_width, box2_height, height], center=true);
}

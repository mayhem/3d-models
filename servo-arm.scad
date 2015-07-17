num_ripples = 24;
md = 5.70;
height = 4.75;
ripple_d = 1.0;
ripple_bottom = 2;

arm_length = 25;
arm_dia = 5.1;

outer_r = 7.75 / 2;
inner_r = 6.0 / 2;
arm_r = arm_dia / 2;


body();

module body()
{
	difference()
	{
		union()
		{
			cylinder(h = height, r = outer_r, center = true, $fn = 32);
			arm();
		}
	    cylinder(h = height+.1, r = inner_r, center = true, $fn = 32);
	}
	ripples();
	translate([0,0, (height / 2) - (ripple_bottom/2)])
		difference()
		{
			cylinder(h = ripple_bottom, r = 7.25 / 2, center = true, $fn = 32);
	    		cylinder(h = ripple_bottom + .1, r = 2.50 / 2, center = true, $fn = 32);
		}
}

module arm()
{
	translate([0, arm_length / 2, 0])
		rotate([0,22.5,0])
			rotate([90,0,0])
				cylinder(h = arm_length, r = arm_r, center = true, $fn = 8);
}

module ripples()
{
	for (i = [0:num_ripples]) 
        assign(deg = (360 / num_ripples) * i)
		{
			translate( [(md / 2) * sin(deg), (md / 2) * cos(deg), 0] ) 
				cylinder(h = height, r1 = ripple_d / 2, r2 = ripple_d / 2, center = true, $fn=16);
		}
}
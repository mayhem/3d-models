num_ripples = 24;
md = 6.50;
height = 4.75;
ripple_d = 1.0;
ripple_bottom = 2;

outer_r = 7.75 / 2;
inner_r = 6.5 / 2;

difference()
{
	cylinder(h = height, r = outer_r, center = true, $fn = 32);
    cylinder(h = height+.1, r = inner_r, center = true, $fn = 32);
}
ripples();
translate([0,0, (height / 2) - (ripple_bottom/2)])
	difference()
	{
		cylinder(h = ripple_bottom, r = 7.25 / 2, center = true, $fn = 32);
    		cylinder(h = ripple_bottom + .1, r = 2.50 / 2, center = true, $fn = 32);
	}

module arm()
{
	


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
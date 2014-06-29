cup();

module cone()
{
    difference() 
	{
    		cylinder(h = 23, r1 = 17.5, r2 = 13, center = true, $fn = 64);
    		cylinder(h = 23, r1 = 15.5, r2 = 11, center = true, $fn = 64);
	}
}

module base()
{
    translate([0, 0, -10])
		difference()
		{
    			cylinder(h = 3, r1 = 17, r2 = 16.5, center = true, $fn = 18);
			cylinder(h = 3, r1 = 2.5, r2 = 4, center = true, $fn = 18);
		}
}

module cup()
{
	union()
	{
		cone();
		base();
	}
}


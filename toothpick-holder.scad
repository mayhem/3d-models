difference() 
{

	cylinder(h = 40, r1 = 4.5, r2 = 3.5, center = true, $fn = 64);
	translate([0,0,1])
    		cylinder(h = 40, r1 = 2.5, r2 = 2.5, center = true, $fn = 64);
}
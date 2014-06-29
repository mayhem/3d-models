upper_cir = 114 / 2;
outer_cir = 97 / 2;
inner_cir = 70 / 2;

union()
{
	translate([0,0,2])
		upper_cylinder();
    lower_cylinder();
}

module upper_cylinder()

{
	difference()
	{
		cylinder(3, upper_cir, upper_cir, $fn=100);
		cylinder(3, inner_cir, inner_cir, $fn=100);
	}; 
}

module lower_cylinder()
{
    	difference()
	{
		cylinder(2, outer_cir, outer_cir, $fn=100);
		cylinder(2, inner_cir, inner_cir, $fn=100);
	};
}
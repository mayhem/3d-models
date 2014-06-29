penne();

height = 30;
id = 4.5;
od = 6;
ripple_d = 1.0;
md = od - (ripple_d / 2);
num_ripples = 20;
pi = 3.14159265;
cut_box_height = 10;
base_height = 1;
base_radius = (od / 2) + 2;

module base()
{
    translate([0, 0, -((height / 2) + (base_height / 2))]) 
    		cylinder(h = base_height, r1 = base_radius, r2 = base_radius, center=true);
}

module cut()
{	
	union()
	{
		translate([0, 0, (height / 2) + (cut_box_height / 2) - 1])
			rotate(a = 45, v=[0,1,0])
				cube([od * 4, od * 4, cut_box_height], center=true);
		translate([0, 0, -((height / 2) + (cut_box_height / 2) - 1)])
			rotate(a = -45, v=[0,1,0])
				cube([od * 4, od * 4, cut_box_height], center=true);
	}
}

module ripples()
{
	for (i = [0:num_ripples]) 
        assign(deg = (360 / num_ripples) * i)
		{
			translate( [(md / 2) * sin(deg), (md / 2) * cos(deg), 0] ) 
				cylinder(h = height, r1 = ripple_d / 2, r2 = ripple_d / 2, center = true, $fn=32);
		}
}

module penne()
{
	union()
	{
	    difference()
		{
			difference()
				{
					union()
					{
						cylinder(h = height, r1 = od / 2, r2 = od / 2, center = true);
						ripples();
					}
					cylinder(h = height, r1 = id / 2, r2 = id / 2, center = true, $fn=64);		
				}
			cut();
		}
		base();
	}
}


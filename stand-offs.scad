// 4mm height, 3mm ID 5mm OD

height = 4.0;
id = 3.0;
od = 5.0;
spacing = od + 2;

for (x = [0 : 3], y = [0 : 3])
{
	standoff(spacing * x, spacing * y);
}

module standoff(x, y)
{
	translate([x, y])
    		difference()
		{
			cylinder(h = height, r = od / 2, $fn=20);
			cylinder(h = height, r = id / 2, $fn=20);
		}
}
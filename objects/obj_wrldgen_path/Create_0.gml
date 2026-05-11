image_blend = c_green

function digCave(x1, y1, x2, y2, steps, step_len, sway, cavewidth) {
	// create path
	var p = path_add();
	x1 += cavewidth * 5
	x2 -= cavewidth * 5
	y1 += cavewidth * 5
	y2 -= cavewidth * 5
	// start somewhere inside the field (center here)
	var px = (x1 + x2) * random_range(3, 7) / 10;
	var py = (y1 + y2) * random_range(3, 7) / 10;
	x = px
	y = py
	
	// initial direction (random)
	var dir = irandom_range(0, 359);

	// add first point
	path_add_point(p, px, py, 100);

	// generate rest of points
	for (var i = 0; i < steps; i++) {
	    // sway direction a bit
	    dir += random_range(-sway, sway);
    
	    // move forward
	    px += lengthdir_x(step_len, dir);
	    py += lengthdir_y(step_len, dir);
    
	    // keep inside rectangle
		var xc = (x1 + x2) / 2
		var yc = (y1 + y2) / 2
		var centerdir = point_direction(px, py, xc, yc)
		var diff = angle_difference(centerdir, dir);
		centerdir = dir + diff;
		var halfW = (x2 - x1) * 0.5;
		var halfH = (y2 - y1) * 0.5;

		var dx = (px - xc) / halfW;
		var dy = (py - yc) / halfH;

		var disFromCenter = sqrt(dx*dx + dy*dy);

		dir = lerp(dir, centerdir, disFromCenter * 0.15)
    
	    // add point
	    path_add_point(p, px, py, 100);
	}

	// optional: smooth the path a bit
	path_set_kind(p, false); // curved instead of straight segments
	path_set_closed(p, false)

	var path_full = step_len * steps

	for (var dist = 0; dist < path_full; dist++) {

	    var px2 = path_get_x(p, dist / path_full)
	    var py2 = path_get_y(p, dist / path_full)
		while true {
			var deswall = instance_nearest(px2, py2, obj_wall) 
			if point_distance(px2, py2, deswall.x, deswall.y) > cavewidth
				break
			instance_destroy(deswall)
		}
	}
	
	return p;
}

for (var i = 0; i < 3; i++) {
	digCave(0, 0, room_width, room_height, random_range(16, 96), random_range(24, 48), random_range(25, 65), random_range(20, 30))
}
for (var i = 0; i < 8; i++) {
	digCave(0, 0, room_width, room_height, random_range(16, 96), random_range(24, 48), random_range(25, 65), random_range(16, 18))
}
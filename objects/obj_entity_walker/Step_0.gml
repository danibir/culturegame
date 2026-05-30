event_inherited()
turnTimer--
switch (behavior) {
	case "think":
		thinktimer--
		if thinktimer <= 0
			behavior = ""
	break
	
	case "":
		behavior = "request_wander"
	break
	
	case "request_wander":
		var radius = 128
		var range = { 
			x1: x - radius, y1: y - radius,
			x2: x + radius, y2: y + radius 
		}
		if array_contains(lastDirection, "right")
			range.x1 = x + radius / 8
		if array_contains(lastDirection, "left")
			range.x2 = x + radius / 8
		if array_contains(lastDirection, "down")
			range.y1 = y - radius / 8
		if array_contains(lastDirection, "up")
			range.y2 = y - radius / 8
		if array_length(lastDirection) = 1 {
			if array_contains(lastDirection, "right") or array_contains(lastDirection, "left") {
				range.y1 = lerp(range.y1, y, 0.5)
				range.y2 = lerp(range.y2, y, 0.5)
			}
			if array_contains(lastDirection, "down") or array_contains(lastDirection, "up") {
				range.x1 = lerp(range.x1, x, 0.5)
				range.x2 = lerp(range.x2, x, 0.5)
			}
		}
		var attempts = 48
		var spots = plotPoint(attempts, range.x1, range.y1, range.x2, range.y2)
		
		spots = array_filter(spots, function (a) {
			var aflag = { x: x, y: y }
			for (var f = 0; f < array_length(memoryflags); f++) {
				var flag = memoryflags[f]
				if f == 0 or point_distance(x, y, aflag.x, aflag.y) < point_distance(x, y, flag.x, flag.y)
					aflag = { x: flag.x, y: flag.y }
			}
			return (point_distance(a.x, a.y, aflag.x, aflag.y) > 64)
		})
		spots = array_filter(spots, function (a) {
			var wall = instance_nearest(a.x, a.y, obj_wall)
			return (point_distance(a.x, a.y, wall.x, wall.y) > 16)
		})
		spots = array_filter(spots, function (a) {
			return (point_distance(x, y, a.x, a.y) > 24)
		})
		if array_length(spots) != 0 {
			setDirection(spots[0].x, spots[0].y)
			walkTowards(spots[0].x, spots[0].y)
			fails = 0
		} else {
			fails++
			behavior = "think"
			thinktimer = 5
			if fails >= 5 {
				lastDirection = []
				fails = 0
			}
		}
	break
	
	
	case "request_explore":
		var attempts = 24
		var size = 256
		var spots = plotPoint(attempts, x - size, y - size, x + size, y + size)
		array_sort(spots, function (a, b) {
			var aflag = { x: x, y: y }
			for (var f = 0; f < array_length(memoryflags); f++) {
				var flag = memoryflags[f]
				if f == 0 or point_distance(x, y, aflag.x, aflag.y) < point_distance(x, y, flag.x, flag.y)
					aflag = { x: flag.x, y: flag.y }
			}
			var bflag = { x: x, y: y }
			for (var f = 0; f < array_length(memoryflags); f++) {
				var flag = memoryflags[f]
				if f == 0 or point_distance(x, y, bflag.x, bflag.y) < point_distance(x, y, flag.x, flag.y)
					bflag = { x: flag.x, y: flag.y }
			}
			var adis = point_distance(aflag.x, aflag.y, a.x, a.y)
			var bdis = point_distance(bflag.x, bflag.y, b.x, b.y)
			return bdis - adis
		})
		if array_length(spots) != 0 {
			walkTowards(spots[0].x, spots[0].y)
		}
	break
	
	
	case "walkTowards":
	
		var total = path_get_number(path_wander);
	    if (pathProgress >= total) {
			pathProgress = 0
	        behavior = "";
	        break;
	    }

	    var nx = path_get_point_x(path_wander, pathProgress);
	    var ny = path_get_point_y(path_wander, pathProgress);

	    var dir = point_direction(x, y, nx, ny);
	    var spd = 0.3;
		var dist = point_distance(x, y, nx, ny)
		if (dist <= 2) {
		    // snap to the point
		    pathProgress++;
		}
		else {
		    xspeed += lengthdir_x(spd, dir);
		    yspeed += lengthdir_y(spd, dir);
		}
	break
}

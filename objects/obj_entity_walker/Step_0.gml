//step event

event_inherited()
turnTimer--

switch (behavior) {
	case "think":
	{
		thinktimer--
		if thinktimer <= 0
			behavior = ""
		break
	}
	
	case "":
	{
		behavior = "request_gotopoint"
		break
	}
	
	case "wriggle": {
		var dir = random(360)
		var _push = 3
		var _x = lengthdir_x(_push, dir)
		var _y = lengthdir_y(_push, dir)
		xspeed += _x
		yspeed += _y
		thinktimer = 90
		behavior = "think"
		break
	}
	
	case "request_gotopoint":
	{
		var attempts = 12
		var poslist = []
		for (var i = 0; i < attempts; i++) {
			array_push(poslist, obj_wrldgen_init.getCaveSpot())
		}
		poslist = array_filter(poslist, function (a) {
			function nearest_flag(px, py) {
		        var best = memoryflags[0]
		        var bestdist = point_distance(px, py, best.x, best.y)
		        for (var i = 1; i < array_length(memoryflags); i++) {
		            var f = memoryflags[i]
		            var d = point_distance(px, py, f.x, f.y)
		            if (d < bestdist) {
		                best = f
		                bestdist = d
		            }
		        }
		        return best
		    }
			function get_path (_x, _y, flag) {
				var path = path_add()
				var success = mp_grid_path(
			        obj_eng.worldGrid, path,
			        _x, _y, flag.x, flag.y,
			        true
			    )
				var dis = path_get_length(path)
				path_delete(path)
				return {success: success, dis, dis}
			}
			var aflag = nearest_flag(a.x, a.y)
			var aresult = get_path(a.x, a.y, aflag)
			return aresult.dis >= 192
		})
		if array_length(poslist) > 0 {
			var posgoal = poslist[0]
			setDirection(posgoal.x, posgoal.y)
			beginWalk(posgoal.x, posgoal.y, "walkflat")
		} else {
			behavior = "wriggle"
		}
		break
	}
	case "request_wander":
	{
		var radius = 512
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
			beginWalk(spots[0].x, spots[0].y, "walkflat")
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
	}
	
	
	case "request_explore":
	{
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
			beginWalk(spots[0].x, spots[0].y, "walkflat")
		}
		break
	}
	
	
	case "walkflat": {
		walkUntil(0.3, function () {
			behavior = ""
		})
		break
	}
}

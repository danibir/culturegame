//step event

event_inherited()

var hasLeader = array_find_index(knownEntities, function (ent) { return ent.state == "alpha" })
var seenEntities = array_filter(knownEntities, function (ent) { return seenBy(ent.instance, self) })
array_sort(seenEntities, function (enta, entb) { return entb.priority - enta.priority })
if hasLeader != -1 {
	var leader = knownEntities[hasLeader]
	target = leader
	if seenBy(leader.instance, self) {
		lost = false
	} else if point_distance(x, y, target.lastLocation.x, target.lastLocation.y) < 4 {
		lost = true
	}
	if lost = true {
		intent = "wandering"
	} else {
		intent = target.instance.intent
		if point_distance(x, y, target.lastLocation.x, target.lastLocation.y) > sightDistance * 0.7 
		or intent = "wandering" {
			intent = "follow"
		}
	}
} else {
	intent = "wandering"
	var ctx  = { target: target, intent: intent }
	var cb = method(ctx, function (ent) {
		if ent.state != "ally"
			show_debug_message(ent.state)
		if ent.state == "possible threat" {
			target = ent
			intent = "stare"
			exit
		}
	})
	array_foreach(knownEntities, cb)
	target = ctx.target
	intent = ctx.intent
}

turnTimer--
switch (intent) {
	case "follow": {
		#region follow
		switch (behavior) {
			default: {
				behavior = ""
				break
			}
			
			case "": {
				behavior = "request_follow"
				break
			}
	
			case "think":
			{
				thinktimer--
				if thinktimer <= 0
					behavior = ""
				break
			}
			case "wriggle": {
				var dir = random(360)
				var _push = 3
				var _x = lengthdir_x(_push, dir)
				var _y = lengthdir_y(_push, dir)
				xspeed += _x
				yspeed += _y
				thinktimer = 15
				behavior = defaultBehavior
				break
			}
	
			case "request_follow":
			{
				var radius = 8
				var range = { 
					x1: target.lastLocation.x - radius, y1: target.lastLocation.y - radius,
					x2: target.lastLocation.x + radius, y2: target.lastLocation.y + radius 
				}
				var point = plotPoint(24, range.x1, range.y1, range.x2, range.y2)
				if array_length(point) > 0 {
					beginWalk(point[0].x, point[0].y, "following", "request_follow")
				} else {
					defaultBehavior = "request_follow"
					behavior = "wiggle"
				}
				break
			}
			case "following":
			{
				walkUntil(0.4, function () {
					behavior = "await"
				})
				break
			}
			case "await":
			{
				if distance_to_object(target.instance) > 16 or !seenBy(target.instance, self) {
					behavior = "request_follow"
				}
				break
			}
		}
		break
	}
	case "wandering": {
		#region wandering
		switch (behavior) {
			default:
			{
				behavior = ""
				break
			}
	
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
		#endregion
		break
	}
}


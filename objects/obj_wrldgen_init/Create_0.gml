
for (var a = 0; a < room_width / 16; a++) {
	for (var b = 0; b < room_height / 16; b++) {
		instance_create_layer(a * 16, b * 16, "Shadow", obj_wall)
	}
}

voidSquares = []
voidSquaresPos = []
cavesWIP = []
complete = false
progress = 0

caveObjs = obj_eng.caveInstances

function digCave(x1, y1, x2, y2, steps, step_len, sway, cavewidth, cavegrow = 1, px = NaN, py = NaN) {
	// create path
		show_debug_message("generating cave")
		var p = path_add();
		x1 += cavewidth * 5
		x2 -= cavewidth * 5
		y1 += cavewidth * 5
		y2 -= cavewidth * 5
		// start somewhere inside the field (center here)
		if (is_nan(px)) {
			px = (x1 + x2) * random_range(4.5, 5.5) / 10;
		}
		if (is_nan(py)) {
			py = (y1 + y2) * random_range(4.5, 5.5) / 10;
		}
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

			var ratio = 2
			var disFromCenter = max((sqrt(dx*dx + dy*dy) * ratio - ratio + 1), 0)

			dir = lerp(dir, centerdir, disFromCenter * 0.25)
    
		    // add point
		    path_add_point(p, px, py, 100);
		}

		// optional: smooth the path a bit
		path_set_kind(p, true); // curved instead of straight segments
		path_set_closed(p, false)
		
		var path_full = step_len * steps
		return {
			path: p,
			path_length: path_full,
			path_width: cavewidth,
			path_grow: cavegrow,
			complete: false,
			offset: 0
		}
}
function carveWorld () {
	show_debug_message("carving world")
	with obj_wall {
		if image_blend != c_dkgray {
			array_push(other.voidSquaresPos, { x, y })
			instance_destroy(self)
		}
	}
}

caves = []
getCaveSpot = function () {
	var failreturn = { x: NaN, y: NaN }
	if array_length(cavesWIP) = 0 
		return failreturn
		
	var pos = random(1)
	var oldcave = cavesWIP[floor(random(array_length(cavesWIP)))].path
	var place = {}
	place.x = path_get_x(oldcave, pos)
	place.y = path_get_y(oldcave, pos)
	return place
}
function placeCave (caveobj) {
	var place = getCaveSpot()
	
	caveobj.px = place.x
	caveobj.py = place.y
	
	var path = digCave(
	0, 0, room_width, room_height, 
	caveobj.steps, caveobj.step_len, caveobj.sway, 
	caveobj.cavewidth, caveobj.cavegrow, caveobj.px, caveobj.py)
	
	array_push(cavesWIP, path)
}

dslist = ds_list_create()
function formCaveStep (maxRange) {
	var count = 0
	
	while true {
		var distanceMade = 0
		var caveIndex = array_find_index(cavesWIP, function (a) {return a.complete == false})
		if caveIndex == -1
			return { complete: true }
		var path = cavesWIP[caveIndex]
		var p = path.path
		var path_full = path.path_length
		var cavewidth = path.path_width
		var cavegrow = path.path_grow
		var precision = 8
		for (var dist = path.offset; dist < path_full; dist += precision) {
			distanceMade++
			var middleness = 1 - 2 * abs(dist / path_full - 0.5)
			var cavesize = lerp(cavewidth, cavewidth * cavegrow, middleness)
			var px2 = path_get_x(p, dist / path_full)
			var py2 = path_get_y(p, dist / path_full)
			var n_wall = instance_nearest(px2, py2, obj_wall)
			var borderwidth = 20
			if point_distance(n_wall.x, n_wall.y, px2, py2) < cavesize + borderwidth + 16 {
				if ds_list_size(dslist) <= 0
					collision_circle_list(px2, py2, cavesize + borderwidth + 16, obj_wall, true, false, dslist, true)
				while (ds_list_size(dslist) > 0) {
					var inst = ds_list_find_value(dslist, 0)
					var distance = point_distance(inst.x, inst.y, px2, py2)
					if distance >= cavesize + borderwidth {
					} else if distance >= cavesize and !array_contains(voidSquares, inst) {
						array_push(voidSquares, inst)
						inst.image_blend = c_dkgray
						count++
					} else if distance < cavesize {
						instance_destroy(inst)
						count++
					}
					if count >= maxRange {
						cavesWIP[caveIndex].offset += distanceMade
						ds_list_clear(dslist)
						return { complete: false }
					}
					ds_list_delete(dslist, 0)
				}
			}
		}
		array_push(caves, p)
		path.complete = true
	}
}

//--------------------------------------


for (var i = 0; i < array_length(caveObjs); i++) {
	placeCave(caveObjs[i])
}
//create event

event_inherited()
walkToPoint = {x, y}
path_wander = path_add()
path_goal = path_add()
goalprogress = 0
fails = 0
thinktimer = 0

target = noone
intent = "wandering"
lost = true

plotPoint = function (attempts, x1, y1, x2, y2) {
	var spots = []
	for (var a = 0; a < attempts; a++) {
		var pos = { 
			x: lerp(x1, x2, random(1)), 
			y: lerp(y1, y2, random(1))
		}
		if !collision_line(x, y, pos.x, pos.y, obj_wall, true, true)
			array_push(spots, pos)
		//var flag = instance_create_layer(pos.x, pos.y, "Instances", obj_memory_flag) //debug for dev, not saved to memoryflags
		//flag.duration = 30000
	}
	return spots
}
pathProgress = 0
beginWalk = function(px, py, next, fail="wiggle") {
	instance_create_layer(x, y, "LoadScreen", obj_memory_flag)
    walkToPoint.x = px;
    walkToPoint.y = py;

    if (!path_exists(path_wander)) {
        path_wander = path_add();
    }

    var success = mp_grid_path(
        obj_eng.worldGrid,
        path_wander,
        x, y,
        walkToPoint.x, walkToPoint.y,
        true
    )

    if (success) {
        behavior = next
		fails = 0
    } else {
		fails++
		if fails >= 5
			behavior = "wriggle"
	}
}
lastDirection = [choose("left", "right", "up", "down")]
turnTimer = 0
setDirection = function (pointx, pointy) {
	if point_direction(x, y, pointx, pointy) < 40 or turnTimer >= 0
		return false
    var ang = point_direction(x, y, pointx, pointy);
    var threshold = 22.5; // tune this: smaller = more sensitive, larger = more "sticky"
	var oldDirection = lastDirection
    // lastDirection is an array like ["right"] or ["right","up"]
    var len = array_length(lastDirection);

    // --- STRAIGHT PREVIOUS DIRECTION ---
	if (len == 0) {
		lastDirection = [choose("left", "right", "up", "down")]
	}
    if (len == 1) {
        var dir = lastDirection[0];
        var base_ang;

        if (dir == "right")  base_ang = 0;
        if (dir == "up")     base_ang = 90;
        if (dir == "left")   base_ang = 180;
        if (dir == "down")   base_ang = 270;

        var rel = angle_difference(ang, base_ang);

        switch (dir) {
            case "right":
                if (rel < -threshold)      lastDirection = ["right","up"];
                else if (rel > threshold)  lastDirection = ["right","down"];
                else                       lastDirection = ["right"];
            break;

            case "left":
                if (rel < -threshold)      lastDirection = ["left","down"];
                else if (rel > threshold)  lastDirection = ["left","up"];
                else                       lastDirection = ["left"];
            break;

            case "up":
                if (rel < -threshold)      lastDirection = ["up","right"];
                else if (rel > threshold)  lastDirection = ["up","left"];
                else                       lastDirection = ["up"];
            break;

            case "down":
                if (rel < -threshold)      lastDirection = ["down","left"];
                else if (rel > threshold)  lastDirection = ["down","right"];
                else                       lastDirection = ["down"];
            break;
        }
    }

    // --- DIAGONAL PREVIOUS DIRECTION ---
    else if (len == 2) {
        var a = lastDirection[0]; // axis A
        var b = lastDirection[1]; // axis B

        // figure out the diagonal base angle
        var base_ang = choose(45, 135, 225, 315);

        if (a == "right" && b == "up")    base_ang = 45;
        if (a == "left"  && b == "up")    base_ang = 135;
        if (a == "left"  && b == "down")  base_ang = 225;
        if (a == "right" && b == "down")  base_ang = 315;

        var rel = angle_difference(ang, base_ang);

        // 25% / 50% / 25% around the diagonal
        if (rel < -threshold) {
            // lean toward axis A
            lastDirection = [a];
        }
        else if (rel > threshold) {
            // lean toward axis B
            lastDirection = [b];
        }
        else {
            // stay diagonal
            lastDirection = [a, b];
        }
    }
	if (lastDirection == oldDirection)
		turnTimer = 30
	return (lastDirection == oldDirection)
}
function walkUntil (walkspeed, func) {
	
	var total = path_get_number(path_wander);
	var nx = path_get_point_x(path_wander, pathProgress)
	var ny = path_get_point_y(path_wander, pathProgress)
	if (pathProgress >= total or collision_line(x, y, nx, ny, obj_wall, false, true)) {
		pathProgress = 0
		func()
		return
	}
	var dir = point_direction(x, y, nx, ny)
	var spd = walkspeed;
	var dist = point_distance(x, y, nx, ny)
	if (dist <= spd * 5) {
		pathProgress++;
	}
	else {
		moving = true
		xspeed += lengthdir_x(spd, dir);
		yspeed += lengthdir_y(spd, dir);
	}
	return
}

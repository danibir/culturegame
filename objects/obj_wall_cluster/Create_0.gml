value = global.import
alignToGrid(16, true, true)
x--
y--
instance_create_layer(x, y, "Instances", obj_wall)


image_blend = c_red

sideToPos = function (side) {
	switch (side) {
			case 0:
			return { x: 16, y: 0 }
			case 1:
			return { x: 0, y: 16 }
			case 2:
			return { x: -16, y: 0 }
			case 3:
			return { x: 0, y: -16 }
		}
}

if value > 0 {
	global.import = value - choose(0.1, 1)
	sides = choose(1, 2, 3)
	availableSides = [0, 1, 2, 3]
	for (var i = 0; i < array_length(availableSides); i++) {
		var xreach = sideToPos(availableSides[i]).x
		var yreach = sideToPos(availableSides[i]).y
		if collision_point(
		x + xreach, 
		y + yreach, 
		obj_wall, false, true) {
			array_delete(availableSides, i, 1)
			i--
		}
		else if collision_point(
		x + xreach * 2, 
		y + yreach * 2, 
		obj_wall, false, true) {
			instance_create_layer(x + xreach, y + yreach, "Instances", obj_wall_cluster)
			array_delete(availableSides, i, 1)
			i--
		}
		
		
	}
	for (var i = 0; i < sides; i++) {
		var xpos = x
		var ypos = y
		if array_length(availableSides) = 0
			break
		var chosenSide = array_get(availableSides, floor(random(array_length(availableSides))))
		switch (chosenSide) {
			case 0:
			xpos += 16
			array_delete(availableSides, array_get_index(availableSides, 0), 1)
			break
			case 1:
			ypos += 16
			array_delete(availableSides, array_get_index(availableSides, 1), 1)
			break
			case 2:
			xpos += -16
			array_delete(availableSides, array_get_index(availableSides, 2), 1)
			break
			case 3:
			ypos += -16
			array_delete(availableSides, array_get_index(availableSides, 3), 1)
			break
		}
		instance_create_layer(xpos, ypos, "Instances", obj_wall_cluster)
	}
}
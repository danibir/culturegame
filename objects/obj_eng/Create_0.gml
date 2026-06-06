show_debug_log(true)
instance_create_layer(x, y, "Instances", obj_mouse)
for (var a = 0; a - 1 < room_width / 16; a++) {
	for (var b = 0; b - 1 < room_height / 16; b++) {
		instance_create_layer(a * 16, b * 16, "Instances", obj_wall)
	}
}
instance_create_layer(x, y, "Instances", obj_wrldgen_init)
instance_create_layer(x, y, "Instances", obj_fortags)
instance_create_layer(x, y, "Instances", obj_cam)
instance_create_layer(x, y, "LoadScreen", obj_loadscreen)

function createSpawn (_entity, _number) 
constructor {
	entity = _entity;
	number = _number;
}

gridSize = 16
worldGrid = mp_grid_create(0, 0, room_width div gridSize, room_height div gridSize, gridSize, gridSize)
initGame = function () {
	var treecount = 150
	for (var i = 0; i < treecount; i++) {
		var pos = obj_wrldgen_init.getCaveSpot()
		var tree = instance_create_layer(pos.x, pos.y, "Instances", obj_tree)
		with tree {
			move_and_collide(random(48) * choose(-1, 1), random(48) * choose(-1, 1), obj_wall)
			alignToGrid(16)
		}
	}
	mp_grid_add_instances(worldGrid, obj_wall, false);
	var spawnEntities = [
	new createSpawn(obj_entity_player, 1),
	new createSpawn(obj_entity_walker, 1)
	]
	
	var positions = []
	var attempts = 10
	for (var a = 0; a < attempts; a++) {
		var newattempt = {
			totaldistance: 0,
			positions: []	
		}
		for (var e = 0; e < array_length(spawnEntities); e++) {
			var pos = obj_wrldgen_init.getCaveSpot()
			var distance = 0
			for (var i = 0; i < array_length(newattempt.positions); i++) {
				var otherpos = newattempt.positions[i].position
				distance += point_distance(pos.x, pos.y, otherpos.x, otherpos.y)
			}
			newattempt.totaldistance = min(distance, newattempt.totaldistance)
			if newattempt.totaldistance == 0
				newattempt.totaldistance = distance
			array_push(newattempt.positions, { entity: spawnEntities[e], position: pos })
		}
		array_push(positions, newattempt)
	}
	array_sort(positions, function (a, b) { return a.totaldistance - b.totaldistance })
	var result = array_pop(positions)
	for (var i = 0; i < array_length(result.positions); i++) {
		var entity = result.positions[i]
		for (var c = 0; c < entity.entity.number; c++) {
			var newentity = instance_create_layer(entity.position.x, entity.position.y, "Instances", entity.entity.entity)
			newentity.x = entity.position.x
			newentity.y = entity.position.y
		}
	}
}
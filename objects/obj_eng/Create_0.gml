show_debug_log(false)
instance_create_layer(x, y, "Instances", obj_mouse)
caveInstances = []
function prescribe_Cave (_steps, _step_len, _sway, _cavewidth, _cavegrow) {
	var caveobj = {
		steps: _steps,
		step_len: _step_len,
		sway: _sway,
		cavewidth: _cavewidth,
		cavegrow: _cavegrow,
		px: NaN,
		py: NaN
	}
	array_push(caveInstances, caveobj)
}
for (var i = 0; i < 11; i++)
	prescribe_Cave(
	random_range(36, 48), 
	random_range(36, 48), 
	random_range(10, 30), 
	random_range(16, 24), 
	random_range(1, 3)
)
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
gameReady = false
gameMenu = false
initGame = function () {
	var treeEach = 24
	for (var i = 0; i < treeEach * array_length(caveInstances); i++) {
		var pos = obj_wrldgen_init.getCaveSpot()
		var tree = instance_create_layer(pos.x, pos.y, "Instances", obj_tree)
		with tree {
			xside = choose(-1, 1)
			yside = choose(-1, 1)
			
			move_and_collide(random(256) * xside, random(256) * yside, obj_wall)
			x -= xside * 4
			y -= yside * 4
		}
	}
	mp_grid_add_instances(worldGrid, obj_wall, false);
	var spawnEntities = [
	new createSpawn(obj_entity_player, 1),
	new createSpawn(obj_entity_walker, 4)
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
		var pack = []
		for (var c = 0; c < entity.entity.number; c++) {
			var newentity = instance_create_layer(entity.position.x, entity.position.y, "Instances", entity.entity.entity)
			newentity.x = entity.position.x
			newentity.y = entity.position.y
			var ctx = { newentity };
			var cb = method(ctx, function(pmember) {
				var index1 = pmember.createMemoryEntity(self.newentity)
				var memory1 = pmember.knownEntities[index1]
				var index2 = self.newentity.createMemoryEntity(pmember)
				var memory2 = self.newentity.knownEntities[index2]
				
				//change object keys...
				var state = "ally"
				var familiarity = 0.8
				memory1.state = state
				memory2.state = state
				memory1.familiarity = familiarity
				memory2.familiarity = familiarity
				
				pmember.knownEntities[index1] = memory1
				self.newentity.knownEntities[index2] = memory2
			})
			array_foreach(pack, cb)
			array_push(pack, newentity)
		}
		if entity.entity.number > 1 {
			array_sort(pack, function (member1, member2) {
				return member2.personality.alpha - member1.personality.alpha
			})
			pack[0].spritecol = c_orange
			pack[0].spritexscale = 1.15
			pack[0].spriteyscale = 1.10
			var ctx = { alphaentity: pack[0], pack }
			var cb = method(ctx, function (pmember) {
				array_foreach(pmember.knownEntities, function (memory) {
					if memory.instance == alphaentity {
						memory.state = "alpha"
					}
				})
			})
			array_foreach(pack, cb)
		}
	}
	gameReady = true
}
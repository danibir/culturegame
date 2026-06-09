xspeed = 0
yspeed = 0

visible = true

age = 0

collisionWTerrain = []
memoryflags = []

behavior = ""

sprite = instance_create_layer(x, y, "Instances", obj_sprite)
sprite.body = self
sprite.sprite = spr_man
spritexscale = 1
spriteyscale = 1
spritecol = c_yellow

sprite_shadow = instance_create_layer(x, y, "Shadow", obj_sprite)
sprite_shadow.body = self
sprite_shadow.sprite = spr_shadow
sprite_shadow.alpha = 0.4
sprite_shadow.depthExempt = true

z = 0
zgrav = 0.25
zspeed = 0
walkbounce = 2
moving = false
visibility = 0
sightDistance = 16*10

personality = {
	alpha: random(1)
}

knownEntities = []
createMemoryEntity = function (instance) {
	var memoryObj = {
		instance: instance,
		
		// relationship
		familiarity: 0,
		relationship: 0,
		state: "possible threat",
		
		// percieved stats
		percievedThreat: 0.3,
		percievedFriendliness: 0,
		confidence: 0.4,
		
		// memory
		lastSeen: age,
		lastInteraction: "noone",
		lastLocation: { x: instance.x, y: instance.y },
		
		//highly fluctuating
		priority: 1
		
	}
	array_push(knownEntities, memoryObj)
	return array_get_index(knownEntities, memoryObj)
}


var spot = obj_wrldgen_init.getCaveSpot()

x = spot.x
y = spot.y
age++

/*
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
		*/
{
	var ctx = { age, caller: id }
	var cb = method(ctx, function (m) {
		if seenBy(m.instance, caller) {
			m.age = age
			m.lastLocation.x = m.instance.x
			m.lastLocation.y = m.instance.y
		}
	})
	array_foreach(knownEntities, cb)
}

//moving and zaxis

if array_contains(collisionWTerrain, "left") and xspeed < 0
	xspeed = 0
if array_contains(collisionWTerrain, "right") and xspeed > 0
	xspeed = 0
if array_contains(collisionWTerrain, "bottom") and yspeed < 0
	yspeed = 0
if array_contains(collisionWTerrain, "top") and yspeed > 0
	yspeed = 0

collisionWTerrain = []

x += xspeed
y += yspeed
zspeed -= zgrav
z += zspeed
if z <= 0
	zspeed = 0
if moving = true {
	if z <= 0
	zspeed = walkbounce
}
moving = false
z = max(0, z)
sprite.yoffset = -z
xspeed *= 0.8
yspeed *= 0.8

//other creatures
var entityList = ds_list_create()
collision_circle_list(x, y, sightDistance, obj_entity, true, true, entityList, true)

var arr = [];
var count = ds_list_size(entityList);

for (var i = 0; i < count; i++) {
    arr[i] = entityList[| i];
}
ds_list_destroy(entityList)

array_foreach(arr, function (ent) {
	if ent != self {
		if !collision_line(ent.x, ent.y, self.x, self.y, obj_wall, false, true) 
		and distance_to_object(ent) < self.sightDistance {
			var knows = false
			if array_length(self.knownEntities) > 0 {
				var ctx = { ent: ent }
				var cb = method(ctx, function (inst) {
					return inst.instance == self.ent
				})
				knows = array_any(self.knownEntities, cb)
			}
			if !knows {
				self.createMemoryEntity(ent)
			}
		}
	}
})


//memoryflags
var knowsplace = false
for (var i = 0; i < array_length(memoryflags); i++) {
	var flag = memoryflags[i]
	if !instance_exists(flag) {
		array_delete(memoryflags, array_get_index(memoryflags, flag), 1)
		i--
	} else {
		if !collision_line(x, y, flag.x, flag.y, obj_wall, true, true) and distance_to_object(flag) < 128 {
			knowsplace = true
			flag.duration = 3000
		}
	}
}
if knowsplace = false {
	var newflag = instance_create_layer(x, y, "Instances", obj_memory_flag)
	array_push(memoryflags, newflag)
}
var convspeed = 1/15
if isVisible() {
	visibility += convspeed
} else {
	visibility -= convspeed
}
visibility = clamp(visibility, 0, 1)
sprite.alpha = lerp(0.4, 1, visibility)
var r = lerp(0, colour_get_red(spritecol), visibility)
var g = lerp(0, colour_get_green(spritecol), visibility)
var b = lerp(0, colour_get_blue(spritecol), visibility)
sprite.col = make_colour_rgb(r, g, b)
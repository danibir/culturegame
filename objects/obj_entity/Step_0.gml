age++



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

with obj_entity { //self is entity instance, other is actual self
	if self != other {
		if !collision_line(self.x, self.y, other.x, other.y, obj_wall, false, true) 
		and distance_to_object(other) < sightDistance {
			var knows = false
			if array_length(other.knownEntities) > 0 {
				knows = array_any(other.knownEntities, function (inst) {
					return inst.instance == self
				})
			}
			if !knows {
				other.createMemoryEntity(self)
			}
		}
	}
}


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
var col = lerp(0, 255, visibility)
sprite.col = make_colour_rgb(col, col, col)
xspeed = 0
yspeed = 0

collisionWTerrain = []
memoryflags = []

behavior = ""
sprite = instance_create_layer(x, y, "Instances", obj_sprite)
sprite.body = self
sprite.sprite = spr_man

var spot = obj_wrldgen_init.getCaveSpot()

x = spot.x
y = spot.y
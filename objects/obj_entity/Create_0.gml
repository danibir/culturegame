xspeed = 0
yspeed = 0

collisionWTerrain = []
memoryflags = []

behavior = ""
sprite = instance_create_layer(x, y, "Instances", obj_sprite)
sprite.body = self
sprite.sprite = spr_man
z = 0
zgrav = 0.25
zspeed = 0
walkbounce = 2
moving = false

var spot = obj_wrldgen_init.getCaveSpot()

x = spot.x
y = spot.y
image_xscale /= 4
image_yscale /= 4
sprite = instance_create_layer(x, y, "Instances", obj_sprite)
sprite.body = self
sprite.sprite = choose(spr_debree0, spr_debree1, spr_debree2, spr_debree3)
sprite.rot = floor(random(360) / 90) * 90

angle = random(1)
zbuff = lerp(0, 2, angle)
movebuff = lerp(2, 0, angle)

z = 0
zgrav = 0.25
zspeed = random_range(0, 1.2) * zbuff

dir = random(360)
spd = random_range(1, 2.5) * movebuff
xspeed = lengthdir_x(spd, dir)
yspeed = lengthdir_y(spd, dir)

size = 1
scale = 1
transparency = { startalpha: 1, endalpha: 1 }
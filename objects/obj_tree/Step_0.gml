var convspeed = 1/15

touched = collision_rectangle(sprite.bbox.left, sprite.bbox.top, sprite.bbox.right, sprite.bbox.bottom, obj_entity, false, false)
seen = false
if instance_exists(obj_entity_player)
	seen = !collision_line(x, y, obj_entity_player.x, obj_entity_player.y, obj_wall, false, false)

if touched and seen{
	sprite.alpha -= convspeed
} else {
	sprite.alpha += convspeed
}
sprite.alpha = clamp(sprite.alpha, 0.4, 1)
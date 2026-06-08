var convspeed = 1/15

touched = collision_rectangle(sprite.bbox.left, sprite.bbox.top, sprite.bbox.right, sprite.bbox.bottom, obj_entity, false, false)
seen = false
if touched {
	with touched {
		other.seen = isVisible()
	}
}

if touched and seen{
	sprite.alpha -= convspeed
} else {
	sprite.alpha += convspeed
}
sprite.alpha = clamp(sprite.alpha, 0.4, 1)
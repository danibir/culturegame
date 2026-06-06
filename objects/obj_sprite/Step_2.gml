if body and instance_exists(body) {
	x = body.x
	y = body.y
}
bbox.left = x + xoffset - sprite_get_xoffset(sprite)
bbox.top = y + yoffset - sprite_get_yoffset(sprite)
bbox.right= bbox.left + sprite_get_width(sprite)
bbox.bottom = bbox.top + sprite_get_height(sprite)

var xdispositon = abs(x - other.x) / other.image_xscale
var ydispositon = abs(y - other.y) / other.image_yscale

if xdispositon > ydispositon
{
	xspeed *= 0.3
	if other.x < self.bbox_right
	{
		array_push(collisionWTerrain, "right")
		x = other.bbox_right + sprite_width / 2
	}
	if other.x > self.bbox_left
	{
		array_push(collisionWTerrain, "left")
		x = other.bbox_left - sprite_width / 2
	}
}
if xdispositon < ydispositon
{
	yspeed *= 0.3
	if other.y < self.bbox_bottom
	{
		array_push(collisionWTerrain, "bottom")
		y = other.bbox_bottom + sprite_height / 2
	}
	if other.y > self.bbox_top
	{
		array_push(collisionWTerrain, "top")
		y = other.bbox_top - sprite_height / 2
	}
}
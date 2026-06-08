var xdispositon = abs(x - other.x) / other.image_xscale
var ydispositon = abs(y - other.y) / other.image_yscale

if xdispositon > ydispositon
{
	xspeed *= 0.6
	yspeed *= 0.5
	if other.x < self.bbox_right
	{
		x = other.bbox_right + sprite_width / 2
	}
	if other.x > self.bbox_left
	{
		x = other.bbox_left - sprite_width / 2
	}
}
if xdispositon < ydispositon
{
	yspeed *= 0.6
	xspeed *= 0.5
	if other.y < self.bbox_bottom
	{
		y = other.bbox_bottom + sprite_height / 2
	}
	if other.y > self.bbox_top
	{
		y = other.bbox_top - sprite_height / 2
	}
}
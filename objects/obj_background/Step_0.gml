slowmouse = {
	x: lerp(slowmouse.x, mouse_x, slowmousespeed),
	y: lerp(slowmouse.y, mouse_y, slowmousespeed)
}

xoffset = lerp(xoffset, (-room_width / 2 + slowmouse.x) * _depth / 1000, lerpspeed)
yoffset = lerp(yoffset, (-room_height / 2 + slowmouse.y) * _depth / 1000, lerpspeed)
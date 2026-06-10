slowmouse = {
	x: lerp(slowmouse.x, mouse_x, slowmousespeed),
	y: lerp(slowmouse.y, mouse_y, slowmousespeed)
}

xoffset = lerp(xoffset, (-room_width / 2 + slowmouse.x) * _depth / 1000, lerpspeed)
yoffset = lerp(yoffset, (-room_height / 2 + slowmouse.y) * _depth / 1000, lerpspeed)

age++
var colBrightness = clamp(lerp(0, 1, (_depth * 6 + age - 60) / 480), 0, 1) * 255
col = make_colour_rgb(colBrightness, colBrightness, colBrightness)
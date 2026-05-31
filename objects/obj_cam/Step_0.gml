
if canManuallyZoom = true
{
	var zoomSentivity = 1.125
	if mouse_wheel_up()
		zoom *= zoomSentivity
	if mouse_wheel_down()
		zoom /= zoomSentivity
}

if tug = true
{
	if mouse_check_button(mb_left)
	{
		var x_dif = tugx - mouse_x
		var y_dif = tugy - mouse_y
		x += x_dif
		y += y_dif
	}
	tugx = mouse_x
	tugy = mouse_y
}

if follow != noone and instance_exists(follow)
{
	var lerpval = 0.25
	x = lerp(x, follow.x + offset_x, lerpval)
	y = lerp(y, follow.y + offset_y, lerpval)
}


view_width = default_view_width / zoom
view_height = default_view_height / zoom
camera_set_view_size(cam, view_width, view_height)
camera_set_view_pos(cam, x - view_width / 2, y - view_height / 2)
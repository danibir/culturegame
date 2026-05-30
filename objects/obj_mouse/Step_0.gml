x = mouse_x
y = mouse_y
if mouse_check_button_pressed(mb_left) {
	obj = collision_point(x, y, all, false, true)
	if obj != noone {
		offsetx = obj.x - x
		offsety = obj.y - y
	}
}
if mouse_check_button(mb_left) {
	if obj != noone {
		obj.x = x + offsetx
		obj.y = y + offsety
	}
}

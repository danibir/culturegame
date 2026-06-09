x = xpos + obj_cam.x - obj_cam.view_width / 2
y = ypos + obj_cam.y - obj_cam.view_height / 2
if collision_point(mouse_x, mouse_y, id, false, false) {
	if mouse_check_button_pressed(mb_left) {
		state = "pressed"
		image_blend = c_gray
	} else if state != "hover" {
		if mouse_check_button(mb_left) {
			state = "held"
			image_blend = c_gray
		} else if mouse_check_button_released(mb_left) {
			state = "released"
			image_blend = c_gray
		} else {
			state = "hover"
			image_blend = c_white
		}
	}
} else {
	state = "inactive"
	image_blend = c_ltgray
}
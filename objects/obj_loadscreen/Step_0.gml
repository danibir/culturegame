x = obj_cam.x - obj_cam.view_width / 2
y = obj_cam.y - obj_cam.view_height / 2


progress = 0 + obj_wrldgen_init.progress
if progress >= 1
	drain--
image_alpha = drain / drainmax
if drain <= 0
	instance_destroy()
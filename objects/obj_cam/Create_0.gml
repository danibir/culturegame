zoom = 1
canManuallyZoom = true
default_view_width = 384
default_view_height = 221

tug = false
tugx = x
tugy = y

follow = obj_camfocus
offset_x = 0
offset_y = 0

cam = camera_create()
camera_set_view_pos(cam, x - default_view_width / 2, y - default_view_height / 2)
camera_set_view_size(cam, default_view_width * zoom, default_view_height * zoom)
camera_apply(cam)
view_set_camera(0, cam)
view_set_visible(0, true)

var w = display_get_width()
var h = display_get_height()
window_set_size(w, h)
window_set_position(0, 0)

image_blend = c_grey

view_enabled = true
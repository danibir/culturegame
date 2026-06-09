draw_set_color(c_black)
draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_set_alpha(image_alpha)
draw_rectangle(
x, 
y, 
x + obj_cam.view_width, 
y + obj_cam.view_height,
false)
var size = {x1: x, x2: x, y1: y, y2: y}
size.x1 = x + obj_cam.view_width * 0.3
size.x2 = x + obj_cam.view_width * 0.7
size.y1 = y + obj_cam.view_height * 0.5
size.y2 = y + obj_cam.view_height * 0.5 + 10

var border = 3
var borderdis = 3

draw_set_color(c_white)
draw_rectangle(
size.x1 - border - borderdis, 
size.y1 - border - borderdis, 
size.x2 + border + borderdis, 
size.y2 + border + borderdis, 
false)

var dots = ""
for (var i = 0; i < dotamount; i++)
	dots += "."
draw_text(size.x1, size.y1 + 16, "Generating map" + dots)
draw_text(size.x1, size.y1 - 32, "(" + string(progress * 100) + "%)")

draw_set_color(c_black)
draw_rectangle(
size.x1 - borderdis, 
size.y1 - borderdis, 
size.x2 + borderdis, 
size.y2 + borderdis, 
false)

draw_set_color(c_lime)
draw_rectangle(size.x1, size.y1, lerp(size.x1, size.x2, progress), size.y2, false)
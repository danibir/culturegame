


obj_camfocus.x = lerp(obj_camfocus.x, x + xspeed * 30, 0.1)
obj_camfocus.y = lerp(obj_camfocus.y, y - sprite.sprite_height / 2 + yspeed * 30, 0.1)

var walkspeed = 0.15
if keyboard_check(vk_shift)
	walkspeed *= 2
if keyboard_check_pressed(vk_space)
	walkspeed *= 20
if keyboard_check_pressed(vk_control) {
	x = mouse_x
	y = mouse_y
}

if keyboard_check(ord("D")) and not array_contains(collisionWTerrain, "right")
{
	xspeed += walkspeed
}
if keyboard_check(ord("A")) and not array_contains(collisionWTerrain, "left")
{
	xspeed -= walkspeed
}
if keyboard_check(ord("S")) and not array_contains(collisionWTerrain, "bottom")
{
	yspeed += walkspeed
}
if keyboard_check(ord("W")) and not array_contains(collisionWTerrain, "top")
{
	yspeed -= walkspeed
}

event_inherited()
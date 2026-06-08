
sharedFocus = { x: x, y: y,}
sharedCount = 0
array_foreach(knownEntities, function (elm) {
	if isVisible(elm.instance) and distance_to_object(elm.instance) < sightDistance {
		sharedFocus.x += elm.instance.x
		sharedFocus.y += elm.instance.y
		sharedCount++
	}
})
sharedFocus.x /= sharedCount + 1
sharedFocus.y /= sharedCount + 1

obj_camfocus.x = lerp(obj_camfocus.x, sharedFocus.x + xspeed * 30, 0.1)
obj_camfocus.y = lerp(obj_camfocus.y, sharedFocus.y - sprite.sprite_height / 2 + yspeed * 30, 0.1)

var walkspeed = 0.15
if keyboard_check(vk_shift)
	walkspeed *= 2.5
if keyboard_check_pressed(vk_space)
	walkspeed *= 20
if keyboard_check_pressed(vk_control) {
	x = mouse_x
	y = mouse_y
}

var moveside = []
if keyboard_check(ord("D")) and not array_contains(collisionWTerrain, "right")
{
	moving = true
	array_push(moveside, "right")
}
if keyboard_check(ord("A")) and not array_contains(collisionWTerrain, "left")
{
	moving = true
	array_push(moveside, "left")
}
if keyboard_check(ord("S")) and not array_contains(collisionWTerrain, "bottom")
{
	moving = true
	array_push(moveside, "down")
}
if keyboard_check(ord("W")) and not array_contains(collisionWTerrain, "top")
{
	moving = true
	array_push(moveside, "up")
}
if array_length(moveside) == 2
	walkspeed *= 0.7

if array_contains(moveside, "right")
	xspeed += walkspeed
if array_contains(moveside, "left")
	xspeed -= walkspeed
if array_contains(moveside, "down")
	yspeed += walkspeed
if array_contains(moveside, "up")
	yspeed -= walkspeed

if keyboard_check(vk_backspace)
	instance_destroy()

event_inherited()
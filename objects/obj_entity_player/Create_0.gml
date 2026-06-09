// Inherit the parent event
event_inherited();
instance_create_layer(x, y, "Instances", obj_camfocus)
sharedFocus = { x: x, y: y }
sharedCount = 0

spritecol = c_lime
cam = instance_create_layer(room_width / 2, room_height / 2, "Instances", obj_cam)
cam.zoom = 0.25
cam.freeCam = true

buttonmenu = instance_create_layer(x, y, "Instances", obj_buttons)
buttonmenu.createButton("start", "Start", room_width / 2, 250, 4, 1)
buttonmenu.createButton("quit", "Close game", room_width / 2, 300, 4, 1)
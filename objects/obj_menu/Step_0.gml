if note != noone and !instance_exists(note) {
	buttonmenu = instance_create_layer(x, y, "Instances", obj_buttons)
	buttonmenu.createButton("start", "Start", room_width / 2, 350, 5, 1)
	buttonmenu.createButton("options", "Options (WIP)", room_width / 2, 400, 5, 1)
	buttonmenu.createButton("quit", "Close game", room_width / 2, 450, 5, 1)
	note = noone
}


if buttonmenu != noone {
	switch (buttonmenu.output) {
		case "start": {
			room_goto(Room1)
			break
		}
		case "quit": {
			game_end()
			break
		}
	}
}
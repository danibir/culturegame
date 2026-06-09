if gameReady = true {
	if keyboard_check_pressed(vk_escape) {
		if gameMenu = false {
			gameMenu = instance_create_layer(x, y, "Instances", obj_buttons)
			gameMenu.createButton("continue", "Start", room_width / 2, 50, 4, 1)
			gameMenu.createButton("quit", "Main menu", room_width / 2, 100, 4, 1)
		} else {
			instance_destroy(gameMenu)
			gameMenu = false
		}
	}
	if gameMenu != false {
		switch (gameMenu.output) {
			case "continue": {
				instance_destroy(gameMenu)
				gameMenu = false
				break
			}	
			case "quit": {
				room_goto(RoomMenu)
				instance_destroy(gameMenu)
				gameMenu = false
				break
			}	
		}
	}
}
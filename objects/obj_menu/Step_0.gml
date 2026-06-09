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
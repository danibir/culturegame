array_foreach(knownEntities, function (m) {
	show_message(m)
	draw_set_colour(c_white)
	if (m.type) == "ally"
		draw_set_colour(c_lime)
	if (m.type) == "leader"
		draw_set_colour(c_green)
	draw_line(x, y, m.instance.x, m.instance.y)
})